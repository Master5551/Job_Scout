import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/users/view/home_page.dart';

import '../users/view/search.dart';

class BottomNavigation extends StatelessWidget {
  final RxInt currentIndex; // Change currentIndex to RxInt
  final List<String> tabLabels;

  BottomNavigation({
    required this.currentIndex,
    required this.tabLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        currentIndex: currentIndex.value, // Use the passed currentIndex
        onTap: (index) {
          if (index == 2) {
            // Use Get.to to navigate to the SearchUsersPage
            Get.to(SearchUsersPage());
          } else if (index == 0) {
            // Handle other tab selections here
            Get.to(HomePage());
          }
        },
        items: List.generate(tabLabels.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(_getIconForIndex(index)),
            label: tabLabels[index],
          );
        }),
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      );
    });
  }

  // Define a method to get the icon based on the index
  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.add;
      case 2:
        return Icons.search;
      case 3:
        return Icons.person;
      default:
        return Icons.home;
    }
  }
}
