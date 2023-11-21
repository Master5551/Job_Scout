import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_scout/User_Module/View/Authentication/Login_page/login_page.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool isPasswordconfirmVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleconfirmPasswordVisibility() {
    isPasswordconfirmVisible.value = !isPasswordconfirmVisible.value;
  }

  Future<void> registerWithEmailAndPassword() async {
    if (!validateInputs()) {
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('Users').doc(userId).set({
        'email': emailController.text.trim(),
      });

      Get.snackbar(
        "Registration Success",
        "User registered successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.to(LoginPage());
    } catch (e) {
      Get.snackbar(
        "Oops..! It Seems Like You have made a mistake",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool validateInputs() {
    return isValidEmail() && isValidPassword() && passwordsMatch();
  }

  bool isValidEmail() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      showValidationError("Validation Error", "Please fill out the email field");
      return false;
    }

    if (!RegExp('[a-z0-9]+@[a-z]+\\.[a-z]{2,3}').hasMatch(email)) {
      showValidationError("Validation Error", "Your Email is badly formatted");
      return false;
    }

    return true;
  }

  bool isValidPassword() {
    String password = passwordController.text.trim();

    if (password.isEmpty) {
      showValidationError("Validation Error", "Password is required");
      return false;
    }

    if (password.length <= 6) {
      showValidationError("Validation Error", "Password should be greater than 6 characters");
      return false;
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      showValidationError("Validation Error", "Password should contain at least one special character");
      return false;
    }

    // Check for at least one digit
    if (!RegExp(r'\d').hasMatch(password)) {
      showValidationError("Validation Error", "Password should contain at least one digit");
      return false;
    }

    return true;
  }

  bool passwordsMatch() {
    if (passwordController.text.trim() != confirmpasswordController.text.trim()) {
      showValidationError("Password Mismatch", "Password and Confirm Password should match");
      return false;
    }
    return true;
  }

  void showValidationError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
