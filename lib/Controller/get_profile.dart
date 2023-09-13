import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserPage extends StatefulWidget {
  @override
  _GetUserPageState createState() => _GetUserPageState();
}

class _GetUserPageState extends State<GetUserPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _getUserData(_user!.uid);
    }
  }

  Future<void> _getUserData(String userId) async {
    try {
      final userData = await _firestore.collection('Users').doc(userId).get();
      if (userData.exists) {
        setState(() {
          _userData = userData.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _user != null
            ? _userData != null
                ? _buildUserCard()
                : const CircularProgressIndicator() // Loading indicator
            : const Text('User not signed in'),
      ),
    );
  }

  Widget _buildUserCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${_userData!['firstName']} ${_userData!['lastName']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Email: ${_userData!['email']}'),
            const SizedBox(height: 8),
            Text('Mobile Number: ${_userData!['mobileNumber']}'),
            const SizedBox(height: 8),
            Text('Profession: ${_userData!['profession']}'),
            const SizedBox(height: 8),
            Text('Date of Birth: ${_userData!['dob']}'),
            const SizedBox(height: 8),
            Text('Title: ${_userData!['title']}'),
            const SizedBox(height: 8),
            Text('About: ${_userData!['about']}'),
          ],
        ),
      ),
    );
  }
}