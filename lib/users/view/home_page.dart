import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Controller/home_controller.dart';
import 'package:job_scout/Controller/home_page_controller.dart';
import 'package:job_scout/users/view/search.dart';
import 'package:job_scout/components/bottom_navigation.dart';

import '../../Controller/logout_controller.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  // Initialize the controller
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Example'),
        actions: <Widget>[
          // Add the "Logout" option to the app bar menu
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Call the logout method from the AuthController
              Get.find<AuthController>().logout();
            },
          ),
          // Add your other menu items here if needed
        ],
      ),
      body: Container(
        child: Text('gjdbgsdjgn'),
      ),
    );
  }
}
