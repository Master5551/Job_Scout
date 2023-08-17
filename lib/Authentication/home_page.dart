import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/images/startpage.png', // Replace with your SVG asset path
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
      ),
    );
  }
}