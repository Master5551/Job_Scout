import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  late PickedFile? imageFile;
  final ImagePicker imagePicker = ImagePicker();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  void takePhoto(ImageSource source) async {
    // final pickedFile = await imagePicker.getImage(source: source);
    // setState(() {
    //  imageFile = pickedFile;
    // });
  }
}

class DataSender {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendUserDataAndNavigate(
    BuildContext context,
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
        };

        await _firestore.collection('Users').doc(user.uid).set(userData);

        
        _firestore.collection('Users').doc(user.uid).collection('Connections').doc().set({});

        Get.toNamed('/bottomnavbar'); 
      } else {
        throw Exception('User is not signed in.');
      }
    } catch (e) {
      throw Exception('Error sending user data: $e');
    }
  }
}