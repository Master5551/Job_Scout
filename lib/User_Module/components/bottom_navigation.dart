import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/User_Module/Controller/company_controller.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Connection/chatting/chat.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Connection/chat.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Home/main_home_page.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Navigation_page/navigation_page.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/d_jobs.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Home/home_page.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/job_notified_page.dart/job_display_page.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/search.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Profile/user_profile_page.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final RxInt currentIndex = 0.obs;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Color accentColor = Colors.teal;

  final List<Widget Function(String)> pages = [
    (currentUserId) => AllCompanyJobPosts(),
    (currentUserId) => UserListPage(
          currentUserId: currentUserId,
        ),
    (currentUserId) => UserSearchScreen(),
    (currentUserId) => JobPostListPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      currentIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[currentIndex.value](currentUser!.uid)),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: onItemTapped,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.public), label: 'Connection'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Status'),
          ],
        ),
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
