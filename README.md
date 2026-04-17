# eye-detecting-keyboard

A small project that detects eye movements and blinks from a webcam and translates them into keyboard actions. This repository provides code and configuration to control a virtual keyboard or send keystrokes using eye gestures.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [How it works](#how-it-works)
- [Configuration](#configuration)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)

## Features

- Real-time eye detection from webcam video using `dlib` and `OpenCV`.
- Recognizes blinks and gaze direction to trigger virtual keyboard events.
- Virtual QWERTY keyboard displayed on screen.
- Sound feedback for key presses (Windows-specific).
- Dynamic download of `shape_predictor_68_face_landmarks.dat` if not present.

## Requirements

- Python 3.8+
- A webcam
- Libraries:
  - `opencv-python`
  - `dlib`
  - `numpy`
  - `winsound` (Windows only, for sound feedback)

Install dependencies using `requirements.txt`:

```bash
pip install -r requirements.txt
```

## Installation

1. Clone the repository:

```bash
git clone https://github.com/Vaishnavi-Manick/eye-detecting-keybord.git
cd eye-detecting-keybord
```

2. (Optional) Create and activate a virtual environment:

```bash
python -m venv venv
# Windows
virtual_env\Scripts\activate
# macOS / Linux
source venv/bin/activate
```

3. Install dependencies:

```bash
pip install -r requirements.txt
```

## Usage

1. Connect a webcam.
2. Run the main script:

```bash
python eye
```

3. The script will automatically download the `shape_predictor_68_face_landmarks.dat` file if it's not found in the current directory.
4. A virtual keyboard and a text board will appear. Look left or right to navigate through the keys, and blink to select a key.

## How it works

The project captures frames from the webcam using `OpenCV`. It then uses `dlib`'s face detector and shape predictor to identify facial landmarks, specifically around the eyes. The script calculates the Eye Aspect Ratio (EAR) to detect blinks and analyzes the distribution of white pixels in the eye region to determine gaze direction. When a blink or a specific gaze pattern (looking left or right) is detected, it triggers a corresponding action on the virtual keyboard, adding the selected character to the text board.

## Configuration

The following parameters can be adjusted within the `eye` script:

- **Blink Detection Threshold**: The `blink_ratio` threshold is set to `5.7`. A value above this indicates a blink.
- **Gaze Detection Thresholds**: 
  - Looking right: `gaze_ratio <= 0.8`
  - Looking left: `gaze_ratio > 1.8`
- **Gaze Delay Counter**: `gaze_delay_counter` is set to `10` to prevent rapid key selections due to continuous gaze.

These values can be modified in the `eye` script to fine-tune performance based on lighting conditions, webcam quality, and individual eye characteristics.

## Development

- Follow standard Python project layout.
- Add unit tests for utility functions (e.g., EAR computation, blink detection logic).
- Keep model and large binary files out of the repository — use Git LFS if necessary.

## Contributing

Contributions are welcome. Please open an issue to discuss major changes before submitting a pull request. When submitting a PR, include a description of the change and any required steps to test.

## License

This project is licensed under the MIT License - see the LICENSE file for details (if available).
