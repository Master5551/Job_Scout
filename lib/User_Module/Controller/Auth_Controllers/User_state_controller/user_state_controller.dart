import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_scout/User_Module/View/Before_master_page/new_user_page.dart';
import 'package:job_scout/User_Module/View/Before_master_page/new_user_page_2.dart';
import 'package:job_scout/User_Module/View/Before_master_page/otp_verify_page.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/profile_page.dart';
import 'package:job_scout/User_Module/components/bottom_navigation.dart';

class UserStateController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId;
  late String useremail;
  String get getUserEmail => useremail;
  bool hasDetails = false;
  bool hasDetails2 = false;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  String imageUrl = '';
  String fileName = '';
  File file = File('');
  late String? downloadLink = '';
  List<String> skills = [];

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController degree = TextEditingController();
  TextEditingController college = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController skill = TextEditingController();

  static String _verificationId = '';

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeUserDetails();
    _isInitialized = true;
    email.text = useremail;
  }

  Future<String?> uploadPdf(String fileName, File file) async {
    final refrence = FirebaseStorage.instance.ref().child("pdfs/$fileName.pdf");

    final UploadTask = refrence.putFile(file);

    await UploadTask.whenComplete(() {});

    final downloadlink = await refrence.getDownloadURL();

    return downloadlink;
  }

  void pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null) {
      fileName = pickedFile.files[0].name;

      file = File(pickedFile.files[0].path!);

      downloadLink = await uploadPdf(fileName, file);

      await _firebaseFirestore.collection("pdfs").add({
        "name": fileName,
        "url": downloadLink,
      });

      print("Pdf Uploaded Succesfully");
    }
  }

  Future<void> _initializeUserDetails() async {
    userId = _auth.currentUser?.uid ?? "";
    useremail = _auth.currentUser?.email ?? "";
    hasDetails = await checkUserDetails(userId);
    hasDetails2 = await checkUserDetails2(userId);

    if (hasDetails == false) {
      await Get.to(NewUserPage());
    } else if (hasDetails2 == false) {
      await Get.to(NewUserPage2());
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

  Future<bool> checkUserDetails2(String userId) async {
    try {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);

      DocumentSnapshot userSnapshot = await userDocRef.get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        if (userData.containsKey('profession') &&
            userData.containsKey('degree') &&
            userData.containsKey('college')) {
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

  String? validateprofession(String value) {
    if (value.isEmpty) {
      return 'Please enter your profession';
    }
    return null;
  }

  String? validatecollege(String value) {
    if (value.isEmpty) {
      return 'Please enter your College name';
    }
    return null;
  }

  String? validatedegree(String value) {
    if (value.isEmpty) {
      return 'Please enter your degree name';
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

  bool performValidations() {
    if (validateFirstName(firstName.text) != null) {
      showSnackbar(validateFirstName(firstName.text)!);
      return false;
    }

    if (validateLastName(lastName.text) != null) {
      showSnackbar(validateLastName(lastName.text)!);
      return false;
    }

    if (validateEmail(email.text) != null) {
      showSnackbar(validateEmail(email.text)!);
      return false;
    }

    if (validatePhoneNumber(mobileNumber.text) != null) {
      showSnackbar(validatePhoneNumber(mobileNumber.text)!);
      return false;
    }

    updateUserData();
    return true;
  }

  bool performValidations2() {
    if (validateprofession(profession.text) != null) {
      showSnackbar(validateprofession(profession.text)!);
      return false;
    }

    if (validatedegree(degree.text) != null) {
      showSnackbar(validatedegree(degree.text)!);
      return false;
    }

    if (validatecollege(college.text) != null) {
      showSnackbar(validatecollege(college.text)!);
      return false;
    }

    updateUserData2();
    return true;
  }

  Future<void> updateUserData() async {
    try {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);

      await userDocRef.set({
        'firstName': firstName.text,
        'lastName': lastName.text,
        'email': email.text,
        'mobileNumber': mobileNumber.text,
        'imageUrl': imageUrl,
        'about': about.text,
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

  Future<void> updateUserData2() async {
    try {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);

      await userDocRef.set({
        'profession': profession.text,
        'degree': degree.text,
        'college': college.text,
        "name": fileName,
        "url": downloadLink,
        "skills": skills,
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

  Future<void> verifyPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      // Automatically sign in the user after phone number verification is successful.
      await _auth.signInWithCredential(phoneAuthCredential);
      // TODO: Navigate to the next screen or perform other actions.
      print('Verification Completed');
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      // Handle the verification failed scenario.
      print('Phone number verification failed. Code: ${authException.code}');
      print('Message: ${authException.message}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      // Save the verification ID for later use.
      // You can use this ID to retrieve the verification code from another source.
      print('Verification ID: $verificationId');
      _verificationId = verificationId;

      // Navigate to the OTP verification screen.
      Get.to(OtpVerificationPage(_verificationId));
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // Auto retrieval timeout, handle it here.
      print("Auto retrieval timeout. Verification ID: $verificationId");
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: '+91${mobileNumber.text}', // Ensure correct phone number format
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
}
