# eye-detecting-keybord

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

- Real-time eye detection from webcam video
- Recognizes blinks and/or gaze direction to trigger keyboard events
- Lightweight setup using OpenCV and a gaze/landmark library (MediaPipe or dlib)
- Example scripts to test and map eye gestures to keys

## Requirements

- Python 3.8+
- A webcam
- Recommended libraries:
  - opencv-python
  - mediapipe or dlib (choose one based on project code)
  - numpy
  - pyautogui (for sending keyboard events)
  - scikit-learn or tensorflow (optional, if using ML models)

If this repository contains a `requirements.txt`, install with:

```
python -m pip install -r requirements.txt
```

Otherwise install the common dependencies manually:

```
python -m pip install opencv-python mediapipe numpy pyautogui
```

## Installation

1. Clone the repository:

```
git clone https://github.com/Vaishnavi-Manick/eye-detecting-keybord.git
cd eye-detecting-keybord
```

2. (Optional) Create and activate a virtual environment:

```
python -m venv venv
# Windows
venv\Scripts\activate
# macOS / Linux
source venv/bin/activate
```

3. Install dependencies (see Requirements above).

## Usage

1. Connect a webcam.
2. Open and inspect the main script (for example `main.py`, `app.py` or `eye_keyboard.py`) to confirm the entry point.
3. Run the script:

```
python main.py
```

4. Follow on-screen instructions to calibrate the eye detector (if provided). Adjust thresholds in the configuration file or inside the script.

Note: If the repository uses a different entry filename, replace `main.py` above with the appropriate script name.

## How it works

The project captures frames from the webcam, detects facial landmarks (especially around the eyes), and computes metrics such as eye aspect ratio (EAR) or gaze direction. When a blink or a specific gaze pattern is detected, the script sends a corresponding keyboard event to the OS (for example, a spacebar press for a blink).

## Configuration

- Thresholds and timings (e.g. EAR threshold, blink duration) are typically set near the top of the main script or in a separate config file. Tune these values per-user and per-camera.
- If you add a calibration routine, document how to run it and where the calibration output is stored.

## Development

- Follow standard Python project layout.
- Add unit tests for utility functions (e.g. EAR computation, blink detection logic).
- Keep model and large binary files out of the repository — use Git LFS if necessary.

## Contributing

Contributions are welcome. Please open an issue to discuss major changes before submitting a pull request. When submitting a PR, include a description of the change and any required steps to test.

## License

Specify the license you want to use (for example MIT). If you haven't chosen a license, add one (e.g. `LICENSE` file) before publishing.

---

If you want, I can push this README.md update to the repository now, or customize sections (usage, entry script name, dependencies) if you tell me the exact main script filename and tech choices used in the project.
