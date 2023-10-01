import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/users/view/Chat/chat.dart';
import 'package:job_scout/users/view/d_jobs.dart';
import 'package:job_scout/users/view/Home/home_page.dart';
import 'package:job_scout/users/view/post_page.dart';
import 'package:job_scout/users/view/search.dart';
import 'package:job_scout/users/view/user_profile_page.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final RxInt currentIndex = 0.obs;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Color accentColor = Colors.teal;

  final List<Widget Function(String)> pages = [
    (currentUserId) => HomePage(),
    (currentUserId) => ChatsScreen1(
          currentUserId: currentUserId,
        ),
    (currentUserId) => UserSearchScreen(),
    (currentUserId) => UserListScreen(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
            BottomNavigationBarItem(
                icon: Icon(Icons.backpack_sharp), label: 'Jobs'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none), label: 'Notification'),
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
