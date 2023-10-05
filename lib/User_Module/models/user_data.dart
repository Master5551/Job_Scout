import 'package:firebase_auth/firebase_auth.dart';

final User? currentUser = FirebaseAuth.instance.currentUser;
class UserModel {
  final String userId; 
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final String profession;
  final String title;
  final String about;
  final String dob;
  

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.profession,
    required this.title,
    required this.about,
    required this.dob,
    
  });

  
  factory UserModel.fromMap(Map<String, dynamic> data) {
  return UserModel(
    userId: currentUser!.uid,
    firstName: data['firstName'],
    lastName: data['lastName'],
    mobileNumber: data['mobileNumber'],
    email: data['email'],
    profession: data['profession'],
    title: data['title'],
    about: data['about'],
    dob: data['dob'],
  );
}
}
