# Flutter Data Management & Persistent Storage — Week 2

A Flutter app demonstrating basic state management (`setState`) and local data persistence (`SharedPreferences`), built as part of a Week 2 Flutter learning plan.

The app has two screens, reachable via the bottom navigation bar:

1. **Counter** — increment/decrement a counter using `setState`; the value is saved to local storage and reloaded automatically on app restart.
2. **To-Do List** — add tasks, mark them complete, delete them, and see them in a scrollable `ListView`; the full list is saved to local storage and persists across restarts.

## Features

### Counter Screen
- `+` / `-` buttons update the counter using `setState`
- Current value is written to `SharedPreferences` on every change
- Value is read back from `SharedPreferences` when the screen loads — close and reopen the app and the count is still there
- Reset button to clear the counter back to 0

### To-Do List Screen
- Text field + button to add new tasks
- Tasks rendered in a `ListView.builder`
- Tap the checkbox to mark a task done/undone (shows a strikethrough)
- Delete icon to remove a task
- The entire list is serialized to JSON and saved in `SharedPreferences` on every change, then deserialized and restored on app start

## Project Structure

```
week2_app/
├── lib/
│   ├── main.dart                   # App entry point + bottom navigation
│   ├── models/
│   │   └── todo_item.dart          # TodoItem model (title, isDone) + JSON (de)serialization
│   └── screens/
│       ├── counter_screen.dart     # setState + SharedPreferences counter
│       └── todo_screen.dart        # To-do list UI + persistence
├── pubspec.yaml
└── README.md
```

## How Persistence Works

- **Counter**: stored as a single integer under the key `counter_value` using `prefs.setInt()` / `prefs.getInt()`.
- **To-Do List**: the list of tasks is converted to a JSON string (`jsonEncode`) and stored under the key `todo_items` using `prefs.setString()`. On load, it's decoded back (`jsonDecode`) into a list of `TodoItem` objects.

`SharedPreferences` stores simple key-value data on the device (it does **not** sync across devices and isn't meant for large or sensitive data — fine for this kind of lightweight local persistence).

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and on PATH
- Android Studio or VS Code with the Flutter/Dart plugins

### Setup
1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd week2_app
   ```
2. Get dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
   Or target a specific device:
   ```bash
   flutter run -d chrome
   ```

## Learning Objectives Covered

- Using `setState` to manage widget state (counter increments/decrements, checkbox toggles, list updates)
- Saving and retrieving primitive data (`int`) with `SharedPreferences`
- Saving and retrieving structured data (a list of objects) with `SharedPreferences` via JSON encoding
- Building a `ListView` of dynamic, user-generated content

## Notes

- `shared_preferences` is added as a dependency in `pubspec.yaml` — run `flutter pub get` after cloning, or the app won't build.
- Data is stored locally per-device; uninstalling the app (or clearing browser storage if running on web) will clear it.



## Author

## Muhammad Abdullah(DHC_5484)
