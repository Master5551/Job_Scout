import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavigation({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.green[300],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'MyNetwork',
          backgroundColor: Colors.green[300],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Post',
          backgroundColor: Colors.green[300],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Jobs',
          backgroundColor: Color.fromARGB(255, 163, 244, 167),
        ),
      ],
    );
  }
}
