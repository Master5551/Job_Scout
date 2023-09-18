import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Controller/home_controller.dart';
import 'package:job_scout/Controller/home_page_controller.dart';
import 'package:job_scout/users/view/search.dart';
import 'package:job_scout/components/bottom_navigation.dart';

class HomePage extends StatelessWidget {
  // Initialize the controller
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Example'),
      ),
      body: Container(child: Text('gjdbgsdjgn'),),
      
    );
  }
}

