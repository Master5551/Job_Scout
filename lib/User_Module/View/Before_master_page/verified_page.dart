import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/User_Module/Controller/Auth_Controllers/User_state_controller/user_state_controller.dart';
import 'package:lottie/lottie.dart';

class VerifiedPage extends StatefulWidget {
  @override
  _VerifiedPageState createState() => _VerifiedPageState();
}

class _VerifiedPageState extends State<VerifiedPage> {
  final UserStateController userController = Get.put(UserStateController());

  @override
  void initState() {
    super.initState();
    _initController();
  }

  Future<void> _initController() async {
    await userController.onInit();
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    if (!userController.isInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: PageView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Lottie.asset(
                'assets/animations/verified_animation.json',
                height: 300,
                reverse: true,
                repeat: false,
                fit: BoxFit.cover,
              ),
              Text('Welcome To Job Scout'),
              Text('As we Provide stable job solution for anyone everywhere'),
            ],
          );
        },
      ),
    );
  }
}
