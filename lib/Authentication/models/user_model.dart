import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore library

class UserModel {
  final String? id;
  final String username;
  final String first_name;
  final String last_name;
  final String mobileno;
  final String email;
  final String password;

  const UserModel({
    this.id,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.mobileno,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "first_name": first_name,
      "last_name": last_name,
      "mobileno": mobileno,
      "email": email,
      "password": password,
    };
  }
}

// Function to add user data to Firestore
Future<void> addUserToFirestore(UserModel user) async {
  // Reference to the Firestore collection where you want to store user data
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

  try {
    // Add a new document with a unique ID
    await usersCollection.add(user.toJson());
    print('User data added to Firestore successfully');
  } catch (e) {
    print('Error adding user data to Firestore: $e');
  }
}

void runApp() {
  final user = UserModel(
    username: "example_username",
    first_name: "John",
    last_name: "Doe",
    mobileno: "1234567890",
    email: "john@example.com",
    password: "password123",
  );

  // Call the function to add user data to Firestore
  addUserToFirestore(user);
}
