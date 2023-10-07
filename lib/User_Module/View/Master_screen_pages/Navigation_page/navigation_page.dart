import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/profile_page.dart';

class ProfileNavigationPage extends StatelessWidget {
  const ProfileNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Scout'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.rotate(
                      angle: 45 * (3.1415926535897932 / 180),
                      child: Icon(
                        Icons.arrow_back,
                        size: 48.0,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        'Hi, Welcome To Job Scout! You Are At the Perfect Place now. Please Fill up the Profile Section So, we can look out for the Best jobs for You...! 😊',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(ProfilePage());
                  },
                  child: Text("Profile Page"))
            ],
          ),
        ),
      ),
    );
  }
}
