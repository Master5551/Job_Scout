import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Controller/home_controller.dart';
import 'package:job_scout/Controller/home_page_controller.dart';
import 'package:job_scout/users/view/Home/Widgets/jobs_list.dart';
import 'package:job_scout/users/view/Profile_drawer/drawer.dart';
import 'package:job_scout/users/view/profile_page.dart';
import 'package:job_scout/users/view/search.dart';
import 'package:job_scout/components/bottom_navigation.dart';
import 'package:job_scout/users/view/user_profile_page.dart';

import '../../../Controller/logout_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.put(AuthController());
  final HomePageController controller = Get.put(HomePageController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void goToProfilePage() {
    Get.to(UserListScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ProfileDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: goToProfilePage,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/searchpage');
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.teal),
                        color: Colors.green.shade100,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search by user name",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.teal,
                            onPressed: () {
                              Get.toNamed('/searchpage');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(Icons.logout),
                  color: Colors.teal,
                  onPressed: () {
                    AuthController().logoutAndRedirectToLogin();
                  },
                ),
              ],
            ),
            JobsList()
          ],
        ),
      ),
    );
  }
}
