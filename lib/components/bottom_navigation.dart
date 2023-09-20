import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/users/Authentication/login_page.dart';
import 'package:job_scout/users/Authentication/register_page.dart';
import 'package:job_scout/users/view/home_page.dart';
import 'package:job_scout/users/view/profile_page.dart';
import 'package:job_scout/users/view/search.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final RxInt currentIndex = 0.obs;

  final List<Widget> pages = [
    HomePage(),
    LoginPage(),
    UserSearchScreen(),
    RegisterPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      currentIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[currentIndex.value]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: [
          _buildBottomNavigationBarItem(Icons.home, 'Home', 0),
          _buildBottomNavigationBarItem(Icons.add, 'Post', 1),
          _buildBottomNavigationBarItem(Icons.search, 'Search', 2),
          _buildBottomNavigationBarItem(Icons.backpack, 'Jobs', 3),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData iconData, String label, int index) {
    return BottomNavigationBarItem(
      icon: Obx(() {
        final current = currentIndex.value;
        final color = current == index ? Colors.teal : Colors.grey;
        return Icon(iconData, color: color);
      }),
      label: label,
    );
  }
}
