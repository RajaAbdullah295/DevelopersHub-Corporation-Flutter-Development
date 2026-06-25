import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  static const String _todoKey = 'todo_items';

  final List<TodoItem> _todos = [];
  final TextEditingController _taskController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  // Loads the saved list of tasks (stored as a JSON string) from local storage.
  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosJson = prefs.getString(_todoKey);

    if (todosJson != null) {
      final List<dynamic> decoded = jsonDecode(todosJson);
      setState(() {
        _todos.addAll(decoded.map((item) => TodoItem.fromJson(item)));
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Encodes the current task list as JSON and saves it to local storage.
  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded =
        jsonEncode(_todos.map((item) => item.toJson()).toList());
    await prefs.setString(_todoKey, encoded);
  }

  void _addTask() {
    final text = _taskController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _todos.add(TodoItem(title: text));
      _taskController.clear();
    });
    _saveTodos();
  }

  void _toggleDone(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
    _saveTodos();
  }

  void _deleteTask(int index) {
    setState(() {
      _todos.removeAt(index);
    });
    _saveTodos();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          // Input row for adding a new task
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Enter a new task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),

          // Task list
          Expanded(
            child: _todos.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks yet. Add one above!',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: todo.isDone,
                            onChanged: (_) => _toggleDone(index),
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: todo.isDone ? Colors.grey : Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () => _deleteTask(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
