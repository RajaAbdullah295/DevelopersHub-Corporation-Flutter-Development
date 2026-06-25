import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../widgets/add_task_dialog.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  static const String _storageKey = 'tasks';

  final List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // --- Persistence -----------------------------------------------------

  // Loads the saved task list (stored as a JSON string) from local storage.
  Future<void> _loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? tasksJson = prefs.getString(_storageKey);

      if (tasksJson != null) {
        final List<dynamic> decoded = jsonDecode(tasksJson);
        _tasks.addAll(decoded.map((item) => Task.fromJson(item)));
      }
    } catch (e) {
      // If decoding ever fails (e.g. corrupted/old data format), log it
      // and start with an empty list rather than crashing the app.
      debugPrint('Error loading tasks: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Encodes the current task list as JSON and saves it to local storage.
  Future<void> _saveTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encoded =
          jsonEncode(_tasks.map((task) => task.toJson()).toList());
      await prefs.setString(_storageKey, encoded);
    } catch (e) {
      debugPrint('Error saving tasks: $e');
    }
  }

  // --- Task actions ------------------------------------------------------

  Future<void> _addTask() async {
    final title = await showAddTaskDialog(context);
    if (title == null || title.isEmpty) return;

    setState(() {
      _tasks.add(
        Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
        ),
      );
    });
    _saveTasks();
  }

  void _toggleComplete(String id) {
    setState(() {
      final task = _tasks.firstWhere((t) => t.id == id);
      task.isCompleted = !task.isCompleted;
    });
    _saveTasks();
  }

  void _deleteTask(String id) {
    final removedTask = _tasks.firstWhere((t) => t.id == id);
    final removedIndex = _tasks.indexOf(removedTask);

    setState(() {
      _tasks.removeWhere((t) => t.id == id);
    });
    _saveTasks();

    // Offer an undo, since deletion is otherwise permanent.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted "${removedTask.title}"'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _tasks.insert(removedIndex, removedTask);
            });
            _saveTasks();
          },
        ),
      ),
    );
  }

  // --- UI ----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final int completedCount = _tasks.where((t) => t.isCompleted).length;

    return Scaffold(
      // Custom app bar: title + a subtitle showing progress, plus an
      // action button in the top-right for adding a task.
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              _tasks.isEmpty
                  ? 'No tasks yet'
                  : '$completedCount of ${_tasks.length} completed',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Task',
            onPressed: _addTask,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tasks.isEmpty
              ? _buildEmptyState()
              : _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.checklist_rtl, size: 72, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No tasks yet',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add your first task',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Dismissible(
          key: Key(task.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => _deleteTask(task.id),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            elevation: 1,
            child: ListTile(
              leading: Checkbox(
                value: task.isCompleted,
                activeColor: Colors.blue,
                onChanged: (_) => _toggleComplete(task.id),
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: task.isCompleted ? Colors.grey : Colors.black87,
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                tooltip: 'Delete',
                onPressed: () => _deleteTask(task.id),
              ),
            ),
          ),
        );
      },
    );
  }
}
