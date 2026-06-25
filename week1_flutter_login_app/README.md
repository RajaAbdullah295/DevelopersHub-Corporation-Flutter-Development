# Flutter Login App — Week 1

A simple Flutter app built as part of a Week 1 Flutter learning plan, covering basic UI building, navigation, and form validation.

## Features

- **Login Screen** — Email and password fields built with `TextFormField`, structured using `Column`, `Row`, and `Container`.
- **Form Validation**
  - Email must be non-empty and match a valid email format.
  - Password must not be empty.
- **Navigation** — Successful login uses `Navigator.push()` to move to the Home Screen.
- **Home Screen** — Displays a welcome message and the logged-in email, with a logout button that returns to the login screen.

## Screenshots

*(Add a screenshot of your login screen and home screen here once you have them, e.g.)*

```
![Login Screen](screenshots/login_screen.png)
![Home Screen](screenshots/home_screen.png)
```

## Project Structure

```
flutter_login_app/
├── lib/
│   ├── main.dart                 # App entry point
│   └── screens/
│       ├── login_screen.dart     # Login UI + validation + navigation
│       └── home_screen.dart      # Post-login screen
├── pubspec.yaml
└── README.md
```

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- Android Studio or VS Code with the Flutter/Dart plugins

### Setup
1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd flutter_login_app
   ```
2. Get dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
   Or target a specific device, e.g.:
   ```bash
   flutter run -d chrome
   ```

## Tech Stack

- **Flutter** (stable channel, 3.44.x)
- **Dart**
- Material Design widgets (`Form`, `TextFormField`, `ElevatedButton`, `Scaffold`)

## Notes

- This project uses `ElevatedButton` instead of the now-removed `FlatButton` widget, since `FlatButton` was deprecated and deleted from current Flutter SDKs. `ElevatedButton` (or `TextButton` for a flat look) is the modern replacement.
- "Forgot Password?" currently just shows a snackbar — it's a placeholder for a future screen/flow.

## Learning Objectives Covered

- Flutter project structure and basic widgets (`Column`, `Row`, `Container`, `Scaffold`)
- Building a responsive login UI
- Form validation using `Form`, `GlobalKey<FormState>`, and `TextFormField` validators
- Screen navigation using `Navigator.push()` and `Navigator.popUntil()`



## Author

## *Muhammad Abdullah(DHC_5484)*
