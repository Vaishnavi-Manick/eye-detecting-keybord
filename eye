import cv2
import numpy as np
import dlib
from math import hypot
import winsound

# Initialize face detector and shape predictor
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")

# Font and display panels
font = cv2.FONT_HERSHEY_PLAIN
keyboard = np.zeros((800, 1000, 3), np.uint8)
board = np.ones((600, 1000, 3), np.uint8) * 255

# Virtual keyboard layout
keys_set = {
    0: "1", 1: "2", 2: "3", 3: "4", 4: "5", 5: "6", 6: "7", 7: "8", 8: "9", 9: "0",
    10: "Q", 11: "W", 12: "E", 13: "R", 14: "T", 15: "Y", 16: "U", 17: "I", 18: "O", 19: "P",
    20: "A", 21: "S", 22: "D", 23: "F", 24: "G", 25: "H", 26: "J", 27: "K", 28: "L",
    29: "Z", 30: "X", 31: "C", 32: "V", 33: "B", 34: "N", 35: "M", 36: " "
}

# Draw a virtual key
def draw_letter(index, text, highlight):
    x = (index % 10) * 100
    y = (index // 10) * 200 if index != 36 else 600
    width = 100 if index != 36 else 1000
    height = 200
    color = (0, 255, 0) if highlight else (255, 0, 0)
    cv2.rectangle(keyboard, (x, y), (x + width, y + height), color, -1)
    text_size = cv2.getTextSize(text, font, 2, 2)[0]
    text_x = x + (width - text_size[0]) // 2
    text_y = y + (height + text_size[1]) // 2
    cv2.putText(keyboard, text, (text_x, text_y), font, 2, (255, 255, 255), 2)

# Calculate midpoint
def midpoint(p1, p2):
    return (p1.x + p2.x) // 2, (p1.y + p2.y) // 2

# Blink detection with error handling
def get_blinking_ratio(eye_points, landmarks):
    left = (landmarks.part(eye_points[0]).x, landmarks.part(eye_points[0]).y)
    right = (landmarks.part(eye_points[3]).x, landmarks.part(eye_points[3]).y)
    top = midpoint(landmarks.part(eye_points[1]), landmarks.part(eye_points[2]))
    bottom = midpoint(landmarks.part(eye_points[5]), landmarks.part(eye_points[4]))

    hor_line = hypot(left[0] - right[0], left[1] - right[1])
    ver_line = hypot(top[0] - bottom[0], top[1] - bottom[1])

    if ver_line == 0:
        return float('inf')  # Avoid ZeroDivisionError
    return hor_line / ver_line

# Gaze direction detection
def get_gaze_ratio(eye_points, landmarks, gray):
    eye_region = np.array([(landmarks.part(pt).x, landmarks.part(pt).y) for pt in eye_points], np.int32)
    mask = np.zeros_like(gray)
    cv2.fillPoly(mask, [eye_region], 255)
    eye = cv2.bitwise_and(gray, gray, mask=mask)

    min_x = np.min(eye_region[:, 0])
    max_x = np.max(eye_region[:, 0])
    min_y = np.min(eye_region[:, 1])
    max_y = np.max(eye_region[:, 1])

    gray_eye = eye[min_y:max_y, min_x:max_x]
    if gray_eye.size == 0:
        return 1  # Neutral if empty

    _, threshold_eye = cv2.threshold(gray_eye, 70, 255, cv2.THRESH_BINARY)
    h, w = threshold_eye.shape
    left = threshold_eye[:, :w // 2]
    right = threshold_eye[:, w // 2:]

    left_white = cv2.countNonZero(left)
    right_white = cv2.countNonZero(right)

    if right_white == 0:
        return 5
    if left_white == 0:
        return 0.1
    return left_white / right_white

# Main loop
cap = cv2.VideoCapture(0)
blinking_frames = 0
gaze_delay_counter = 0
letter_index = 0
text = ""

while True:
    ret, frame = cap.read()
    if not ret:
        break
    frame = cv2.resize(frame, None, fx=0.5, fy=0.5)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    keyboard[:] = (0, 0, 0)

    faces = detector(gray)
    if len(faces) == 0:
        for i in range(len(keys_set)):
            draw_letter(i, keys_set[i], i == letter_index)
        cv2.imshow("Keyboard", keyboard)
        cv2.imshow("Frame", frame)
        cv2.imshow("Text Board", board)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
        continue

    for face in faces:
        landmarks = predictor(gray, face)

        # Blink Detection
        left_ratio = get_blinking_ratio([36, 37, 38, 39, 40, 41], landmarks)
        right_ratio = get_blinking_ratio([42, 43, 44, 45, 46, 47], landmarks)
        blink_ratio = (left_ratio + right_ratio) / 2

        if blink_ratio > 5.7:
            blinking_frames += 1
            if blinking_frames == 5:
                text += keys_set[letter_index]
                winsound.Beep(500, 100)
                blinking_frames = 0
        else:
            blinking_frames = 0

        # Gaze Detection
        if gaze_delay_counter == 0:
            gaze_ratio = get_gaze_ratio([36, 37, 38, 39, 40, 41], landmarks, gray)

            if gaze_ratio <= 0.8:  # Looking right
                letter_index = (letter_index + 1) % len(keys_set)
                gaze_delay_counter = 10
            elif gaze_ratio > 1.8:  # Looking left
                letter_index = (letter_index - 1) % len(keys_set)
                gaze_delay_counter = 10
        else:
            gaze_delay_counter -= 1

    # Draw keyboard
    for i in range(len(keys_set)):
        draw_letter(i, keys_set[i], i == letter_index)

    # Update text board
    board[:] = 255
    lines = [text[i:i + 50] for i in range(0, len(text), 50)][-10:]
    for i, line in enumerate(lines):
        cv2.putText(board, line, (10, 50 + i * 50), font, 2, (0, 0, 0), 2)

    # Show windows
    cv2.imshow("Keyboard", keyboard)
    cv2.imshow("Frame", frame)
    cv2.imshow("Text Board", board)

    if cv2.waitKey(1) == 27:
        break

cap.release()
cv2.destroyAllWindows()










import os
import dlib
import cv2
import urllib.request

print(f"Current working directory: {os.getcwd()}")

# Download the face landmark predictor file if it doesn't exist
predictor_path = "shape_predictor_68_face_landmarks.dat"
if not os.path.isfile(predictor_path):
    print("Downloading shape predictor file...")
    url = "https://github.com/italojs/facial-landmarks-recognition/raw/master/shape_predictor_68_face_landmarks.dat"
    urllib.request.urlretrieve(url, predictor_path)
    print("Download complete!")

# Initialize the face detector and shape predictor
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor(predictor_path)

print("Face detector and shape predictor initialized successfully!")
