
import 'package:flutter/material.dart';
import 'package:job_scout/users/Authentication/login_page.dart';
import 'package:job_scout/users/Authentication/register_page.dart';
import 'package:job_scout/users/view/home_page.dart';
import 'package:job_scout/users/view/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  List<Widget> _pages = [
    // Define your pages here
    // Example: HomePage(), ProfilePage(), etc.
    LoginPage(),LoginPage(),LoginPage(),RegisterPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.macro_off),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.female),
            label: 'Profile',
          ),
          // Add more bottom navigation bar items as needed
        ],
      ),
    );
  }
}
