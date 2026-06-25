import 'package:flutter/material.dart';
import 'screens/counter_screen.dart';
import 'screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 2 - Data & Storage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeNavigation(),
    );
  }
}

/// Hosts both Week 2 tasks (Counter + To-Do List) behind a bottom nav bar
/// so you can demo both features from a single running app.
class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    CounterScreen(),
    TodoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.exposure),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'To-Do List',
          ),
        ],
      ),
    );
  }
}
