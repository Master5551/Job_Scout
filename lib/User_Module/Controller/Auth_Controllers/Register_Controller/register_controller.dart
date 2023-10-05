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
    try {
      if (!isValidEmail() || !isValidPassword()) {
        return;
      }

      if (passwordController.text.trim() != confirmpasswordController.text.trim()) {
        Get.snackbar(
          "Password Mismatch",
          "Password and Confirm Password should match",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

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

  bool isValidEmail() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        "Validation Error",
        "Please fill out the email field",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (!RegExp('[a-z0-9]+@[a-z]+\\.[a-z]{2,3}').hasMatch(email)) {
      Get.snackbar(
        "Validation Error",
        "Your Email is badly formatted",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  bool isValidPassword() {
  String password = passwordController.text.trim();

  if (password.isEmpty) {
    Get.snackbar(
      "Validation Error",
      "Password is required",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return false;
  }

  if (password.length <= 6) {
    Get.snackbar(
      "Validation Error",
      "Password should be greater than 6 characters",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return false;
  }

  // Check for at least one special character
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    Get.snackbar(
      "Validation Error",
      "Password should contain at least one special character",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return false;
  }

  // Check for at least one digit
  if (!RegExp(r'\d').hasMatch(password)) {
    Get.snackbar(
      "Validation Error",
      "Password should contain at least one digit",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return false;
  }

  return true;
}

}
