import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week3_task_manager/screens/task_list_screen.dart';

void main() {
  testWidgets('Task list shows empty state and can add a task',
      (WidgetTester tester) async {
    // SharedPreferences normally talks to native platform code, which
    // doesn't exist in the test environment. This sets up an in-memory
    // mock so .getInstance() resolves immediately instead of hanging.
    SharedPreferences.setMockInitialValues({});

    // Build the Task List screen in isolation.
    await tester.pumpWidget(
      const MaterialApp(home: TaskListScreen()),
    );

    // Let SharedPreferences load (initState's async call) settle.
    await tester.pumpAndSettle();

    // With no saved tasks, the empty state message should be visible.
    expect(find.text('No tasks yet'), findsWidgets);

    // Tap the app bar's add icon to open the add-task dialog.
    await tester.tap(find.widgetWithIcon(IconButton, Icons.add));
    await tester.pumpAndSettle();

    // Type a task title and confirm with the Add button.
    await tester.enterText(find.byType(TextField), 'Buy groceries');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
    await tester.pumpAndSettle();

    // The new task should now appear in the list.
    expect(find.text('Buy groceries'), findsOneWidget);
  });
}