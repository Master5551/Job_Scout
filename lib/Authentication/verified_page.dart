import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VerifiedPage extends StatefulWidget {
  const VerifiedPage({super.key});

  @override
  State<VerifiedPage> createState() => _VerifiedPageState();
}

class _VerifiedPageState extends State<VerifiedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animations/verified_animation.json',height: 300,reverse: true,repeat: true,fit: BoxFit.cover),
              Text('Welcome To Job Scout'),
              Text('As we Provide stable job solution for anyone everywhere'),

            ],
          );
        },
      ),
    );
  }
}
