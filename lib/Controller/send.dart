// send_data.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendDataPage extends StatefulWidget {
  @override
  _SendDataPageState createState() => _SendDataPageState();
}

class _SendDataPageState extends State<SendDataPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  // Function to get the current user
  Future<void> _getUser() async {
    User? user = _auth.currentUser;
    setState(() {
      _user = user;
    });
  }

  // Function to insert user data into Firestore
  Future<void> _insertUserData() async {
    if (_user != null) {
      try {
        // Define the data you want to insert
        Map<String, dynamic> userData = {
          'userId': _user!.uid,
          'email': _user!.email,
          // Add more fields as needed
        };

        // Use the user's UID as the document ID
        await _firestore.collection('users').doc(_user!.uid).set(userData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User data inserted into Firestore successfully.'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error inserting user data not: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User is not signed in.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Data to Firestore'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_user != null)
              Text('Logged in as: ${_user!.email}'),
            ElevatedButton(
              onPressed: _insertUserData,
              child: Text('Insert User Data'),
            ),
          ],
        ),
      ),
    );
  }
}

 
