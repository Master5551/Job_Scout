import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/User_Module/components/bottom_navigation.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Home/home_page.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/profile_page.dart';
import 'package:lottie/lottie.dart';

class VerifiedPage extends StatelessWidget {
  VerifiedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      
      Get.offAll(() => BottomNavBar());
    });

    return Scaffold(
      body: PageView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animations/verified_animation.json',
                  height: 300, reverse: true, repeat: false, fit: BoxFit.cover),
              Text('Welcome To Job Scout'),
              Text('As we Provide stable job solution for anyone everywhere'),
            ],
          );
        },
      ),
    );
  }
}