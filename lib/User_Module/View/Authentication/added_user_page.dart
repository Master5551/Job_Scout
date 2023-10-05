import 'package:flutter/material.dart';
import 'package:job_scout/User_Module/View/Authentication/Login_page/login_page.dart';
import 'package:job_scout/User_Module/components/bottom_navigation.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/profile_page.dart';
import 'package:lottie/lottie.dart';

class AddedUserPage extends StatefulWidget {
  const AddedUserPage({Key? key}) : super(key: key);

  @override
  State<AddedUserPage> createState() => _AddedUserPageState();
}

class _AddedUserPageState extends State<AddedUserPage> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 5), () {
      
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            LoginPage(), 
      ));
    });
  }

  @override
    
  Widget build(BuildContext context) {
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
