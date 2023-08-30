import 'package:flutter/material.dart';
import 'package:job_scout/Authentication/login_page.dart';
import 'package:lottie/lottie.dart';

class VerifiedPage extends StatefulWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  @override
  State<VerifiedPage> createState() => _VerifiedPageState();
}

class _VerifiedPageState extends State<VerifiedPage> {
  @override
  void initState() {
    super.initState();
    // Delay navigation by 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the desired page
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            LoginPage(), // Replace YourNextPage with the actual page you want to navigate to
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
