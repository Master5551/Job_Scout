import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_scout/User_Module/View/Before_master_page/new_user_page.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/profile_page.dart';
import 'package:job_scout/User_Module/components/bottom_navigation.dart';

class UserStateController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId;
  late String useremail;
  String get getUserEmail => useremail;
  bool hasDetails = false;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeUserDetails();
    _isInitialized = true;
  }

  Future<void> _initializeUserDetails() async {
    userId = _auth.currentUser?.uid ?? "";
    useremail = _auth.currentUser?.email ?? "";
    hasDetails = await checkUserDetails(userId);

    if (hasDetails == false) {
      await Get.to(NewUserPage());
    } else {
      await Get.to(BottomNavBar());
    }
  }

  Future<bool> checkUserDetails(String userId) async {
    try {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);

      DocumentSnapshot userSnapshot = await userDocRef.get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        if (userData.containsKey('firstName') &&
            userData.containsKey('lastName')) {
          return true;
        }
      }
    } catch (e) {
      print("Error checking user details: $e");
    }

    return false;
  }

  String getUserId() {
    return userId;
  }

  // Validate First Name
  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  // Validate Email
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email address';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validate Phone Number
  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Function to show Snackbar
  void showSnackbar(String message) {
    Get.snackbar(
      'Validation Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  // Your function to perform the validations and show Snackbar
  void performValidations() {
    if (validateFirstName(firstName.text) != null) {
      showSnackbar(validateFirstName(firstName.text)!);
      return;
    }

    if (validateLastName(lastName.text) != null) {
      showSnackbar(validateLastName(lastName.text)!);
      return;
    }

    if (validateEmail(email.text) != null) {
      showSnackbar(validateEmail(email.text)!);
      return;
    }

    if (validatePhoneNumber(mobileNumber.text) != null) {
      showSnackbar(validatePhoneNumber(mobileNumber.text)!);
      return;
    }

    // If all validations pass, update the user data
    updateUserData();
  }

  // Function to update user data in Firestore
  Future<void> updateUserData() async {
    try {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);

      await userDocRef.set({
        'firstName': firstName.text,
        'lastName': lastName.text,
        'email': email.text,
        'mobileNumber': mobileNumber.text,
      }, SetOptions(merge: true));

      Get.to(BottomNavBar());
    } catch (e) {
      print("Error updating user data: $e");
      // Handle error, show a Snackbar, or perform any other actions
    }
  }
}
