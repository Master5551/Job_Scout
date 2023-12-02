import 'package:firebase_auth/firebase_auth.dart';

final User? currentUser = FirebaseAuth.instance.currentUser;

class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final String profession;
  final String college;
  final String degree;
  final String imageUrl;
  final String url;

  UserModel({
    
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.profession,
    required this.college,
    required this.degree,
    required this.imageUrl,
    required this.url,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      mobileNumber: data['mobileNumber'],
      email: data['email'],
      profession: data['profession'],
      college: data['college'],
      degree: data['degree'],
      imageUrl: data['imageUrl'],
      url: data['url'],
    );
  }
}
