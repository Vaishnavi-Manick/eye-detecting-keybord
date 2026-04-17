# Eye-Controlled Virtual Keyboard for Physically Abled User Interaction

**Authors:** 
- **Aadheeshwar A** (aadheeprasanna@gmail.com)
- **Swathika G** (gswathika43@gmail.com)
- **Vineesh M** (vineeshxd3@gmail.com)
*Department of AIDS, Saveetha Engineering College, Chennai, India*

---

## Abstract
Accessibility remains a major barrier in today's digital world for those with physical disabilities, making it more difficult for them to use technology easily. The "Eye-Controlled Virtual Keyboard" project aims to improve user engagement and communication by utilizing eye-tracking technology. By providing an innovative interface that allows navigating and typing with only eye movements, the system empowers those with limited mobility. Utilizing real-time video processing with **OpenCV**, **NumPy**, and **dlib**, the system performs accurate facial landmark detection and gaze tracking. Eye blinking detection is used to "activate" keys on a virtual keyboard, fostering independence and raising the standard of living for those with physical disabilities.

---

## I. Introduction
The **Gaze Controlled Keyboard** is an innovative system designed to facilitate typing for users through eye movements alone. Primarily targeted at individuals with motor disabilities, it enables hands-free interaction with a virtual keyboard. The system interprets where a user is looking on the screen, allowing them to focus on specific keys and select them using gaze or blinks. This solution is ideal for people with limited mobility, providing an essential tool for digital communication.

### Problem Definition
Traditional input devices like keyboards and touchscreens require fine motor control, which is often not feasible for users with disabilities. This creates a barrier to digital communication and essential technology. The project overcomes these challenges by creating a virtual keyboard interface controlled solely by eye movements, ensuring a reliable, accurate, and intuitive user experience.

---

## II. System Features & Technical Specifications

### Key Features
| Feature | Description |
| :--- | :--- |
| **Real-Time Eye Tracking** | High-precision tracking using `dlib` frontal face detector and 68-landmark predictor. |
| **Blink-to-Select** | Uses Eye Aspect Ratio (EAR) to detect intentional blinks as selection triggers. |
| **Gaze Navigation** | Analyzes eye region white-pixel distribution to navigate left/right through the keyboard. |
| **Visual Feedback** | Real-time display of the camera feed, virtual keyboard, and a text board for typed content. |
| **Auditory Confirmation** | Integrated `winsound` feedback to confirm key selections (Windows-compatible). |

### Technical Requirements
- **Language:** Python 3.8+
- **Core Libraries:** `opencv-python`, `dlib`, `numpy`, `math`
- **Environment:** Ubuntu 22.04 / Windows
- **Hardware:** Standard Webcam, Intel Xeon Family or equivalent processor.

---

## III. System Implementation

### A. Module 1: Facial Landmark Detection
The system initializes the `dlib` face detector and loads the `shape_predictor_68_face_landmarks.dat` model. If the model is missing, the script includes an automated routine to download it from a remote repository.

### B. Module 2: Eye Aspect Ratio (EAR) & Blink Detection
The system calculates the ratio of the distance between vertical eye landmarks to the distance between horizontal eye landmarks.
- **Formula:** `EAR = (dist(top, bottom)) / (dist(left, right))`
- **Threshold:** A `blink_ratio > 5.7` maintained for 5 frames triggers a key selection.

### C. Module 3: Gaze Ratio Analysis
The eye region is isolated using a mask, and the ratio of white pixels in the left half versus the right half of the eye is calculated.
- **Looking Right:** `gaze_ratio <= 0.8`
- **Looking Left:** `gaze_ratio > 1.8`
- **Navigation:** Moves the `letter_index` through the `keys_set` dictionary.

### D. Module 4: Virtual Keyboard & Display
A custom QWERTY layout is rendered using OpenCV's `cv2.rectangle` and `cv2.putText`.
- **Keyboard Size:** 1000x800 pixels.
- **Text Board:** A separate window displaying the cumulative typed text.

---

## IV. Usage Instructions

1.  **Installation:** Clone the repository and install dependencies via `pip install -r requirements.txt`.
2.  **Execution:** Run the script using `python eye`.
3.  **Calibration:** Ensure the face is well-lit and centered in the webcam frame.
4.  **Navigation:** Look to the left or right to move the highlight across the virtual keys.
5.  **Selection:** Perform a deliberate blink (approx. 0.5 seconds) to select the highlighted key.
6.  **Termination:** Press the `Esc` key to exit the application.

---

## V. Conclusion and Future Enhancements

### Conclusion
The Eye-Controlled Virtual Keyboard demonstrates the transformative role of AI in assistive technology. By replacing physical input with gaze and blink detection, it provides a robust tool for independent digital communication. The system's reliance on standard hardware makes it an accessible and scalable solution for users worldwide.

### Future Enhancements
- **Multi-Language Support:** Expanding the keyboard layout to include non-English characters.
- **Predictive Text:** Integrating NLP models to suggest words based on initial characters, increasing typing speed.
- **Cloud Integration:** Allowing users to save their typed documents directly to cloud storage.
- **Mobile Compatibility:** Porting the logic to mobile platforms for on-the-go communication.

---
*Documentation generated by Manus AI for the Eye-Detecting Keyboard Project.*
