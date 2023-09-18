import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/users/Authentication/verified_page.dart';

class DataSender {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendUserDataAndNavigate(
    BuildContext context, // Pass the context
    String firstName,
    String lastName,
    String mobileNumber,
    String profession,
    String dob,
    String title,
    String about,
  ) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Define the data you want to insert
        Map<String, dynamic> userData = {
          'userId': user.uid,
          'email': user.email,
          'firstName': firstName,
          'lastName': lastName,
          'mobileNumber': mobileNumber,
          'profession': profession,
          'dob': dob,
          'title': title,
          'about': about,
          // Add more fields as needed
        };

        // Use the user's UID as the document ID
        await _firestore.collection('Users').doc(user.uid).set(userData);

        // Insertion successful, navigate to another page
        Get.toNamed('/bottomnavbar');
      } else {
        throw Exception('User is not signed in.');
      }
    } catch (e) {
      throw Exception('Error sending user data: $e');
    }
  }
}
