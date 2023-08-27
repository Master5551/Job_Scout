import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('data'),
          actions: [
            IconButton(
                onPressed: () {
                  
                  Navigator.pop(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
