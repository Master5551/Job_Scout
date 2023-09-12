// send_data.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_scout/Authentication/verified_page.dart'; // Import Material package

class DataSender {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> insertUserDataAndNavigate(BuildContext context) async { // Add context as a parameter
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        // Define the data you want to insert
        Map<String, dynamic> userData = {
          'userId': user.uid,
          'email': user.email,
          // Add more fields as needed
        };

        // Use the user's UID as the document ID
        await _firestore.collection('Users').doc(user.uid).set(userData);

        // Insertion successful, you can now navigate to another page
        // Example:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => VerifiedPage(),
          ),
        );
      } catch (e) {
        throw Exception('Error inserting user data: $e');
      }
    } else {
      throw Exception('User is not signed in.');
    }
  }
}