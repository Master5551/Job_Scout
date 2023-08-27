import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      await GoogleSignIn().disconnect();
      FirebaseAuth.instance.signOut();
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('data'),
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
