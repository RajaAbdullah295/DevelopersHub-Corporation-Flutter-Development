# Task Manager — Week 3 Final Project

A complete task management app built as the Week 3 capstone project, combining UI building, navigation, state management, and persistent local storage from Weeks 1–2 into a single functional app.

## Features

- **Splash Screen** — branded loading screen shown for 2 seconds on launch (bonus enhancement)
- **Home Screen** — list of all tasks, with a custom app bar showing a live "X of Y completed" progress subtitle
- **Add a Task** — via the `+` action button in the app bar, or the floating action button; opens a dialog to type the task title
- **Mark Complete** — tap the checkbox next to a task; completed tasks get a strikethrough style
- **Delete a Task** — swipe a task left, or tap the trash icon; shows a Snackbar with an **Undo** option
- **Persistent Storage** — the full task list is saved to `SharedPreferences` (as JSON) every time it changes, and reloaded automatically when the app restarts
- **Empty State** — friendly message and icon shown when there are no tasks yet



## Project Structure

```
week3_task_manager/
├── lib/
│   ├── main.dart                     # App entry point
│   ├── models/
│   │   └── task.dart                 # Task model + JSON (de)serialization
│   ├── screens/
│   │   ├── splash_screen.dart        # Bonus: splash screen on launch
│   │   └── task_list_screen.dart     # Home screen: list, add, delete, complete, persistence
│   └── widgets/
│       └── add_task_dialog.dart      # Reusable "Add Task" dialog
├── test/
│   └── widget_test.dart              # Basic widget test (empty state + add task)
├── pubspec.yaml
└── README.md
```

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and on your system PATH
- Android Studio or VS Code with the Flutter/Dart plugins installed
- A connected device, emulator, or a browser (Chrome/Edge) to run on

Run `flutter doctor` to confirm your setup is ready — resolve any ❌ items it reports.

### Setup
1. Clone this repository:
   ```bash
   git clone <https://github.com/RajaAbdullah295/DevelopersHub-Corporation-Flutter-Development.git>
   cd week3_task_manager
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
   This pulls in `shared_preferences`, used for persistence.
3. Run the app:
   ```bash
   flutter run
   ```
   Or target a specific device:
   ```bash
   flutter run -d chrome
   ```

### Running Tests
```bash
flutter test
```
This runs `test/widget_test.dart`, which verifies the empty-state message appears and that adding a task makes it show up in the list.

## Testing & Debugging Notes

This project was tested and debugged using:
- **Hot reload** (`r` in the terminal, or the lightning bolt in VS Code) to quickly iterate on UI changes
- **`debugPrint()`** statements in the load/save functions (`task_list_screen.dart`) to trace `SharedPreferences` read/write issues
- **Flutter DevTools** (opens automatically when running with `flutter run`, or via VS Code's "Open DevTools" button) to inspect the widget tree and check for rebuild issues
- **Manual navigation testing** — confirmed the splash screen transitions correctly to the task list, and that tasks persist correctly after a full app restart (not just hot reload)
- **`flutter analyze`** to catch lint/static-analysis issues before running

## Learning Objectives Covered

- Combining UI building, navigation, state management, and persistence into one working app
- Custom `AppBar` with a title, subtitle, and an action `IconButton`
- Use of Material icons (`Icons.add`, `Icons.delete_outline`, `Icons.checklist_rtl`, `Icons.task_alt`, etc.) for visual clarity
- Testing and debugging using Flutter's built-in tools
- `Dismissible` widgets, `Snackbar` with undo actions, and empty-state UX patterns

## Bonus Challenges

-  **Splash screen** — implemented in `lib/screens/splash_screen.dart`
-  **Firebase integration** — not implemented (optional, listed as not required for beginners)

## Deliverables Checklist

- [x] Functional task management app (add, delete, mark complete, persisted)
- [x] GitHub repository with code and this README (setup instructions included above)
- [ ] Short demo video — record a screen capture showing: launching the app (splash screen), adding a task, marking it complete, deleting a task, and restarting the app to show persistence

## Author

## Muhammad Abdullah(DHC_5484)

