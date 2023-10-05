import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_scout/users/Authentication/verified_page.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  final isPasswordValid = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void setEmail(String value) {
    emailController.text = value;
  }

  void setPassword(String value) {
    passwordController.text = value;
  }

  void setIsLoading(bool value) {
    isLoading.value = value;
  }

 void submitForm() {
  if (_isValidEmail() && _isValidPassword()) {
    // Form is valid, you can perform your login logic here
  }
}

bool _isValidEmail() {
  String email = emailController.text.trim();

  if (email.isEmpty) {
    Get.snackbar(
        "OOps..! It Seems Like You have made a mistake",
        "please Fill out the email field",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    return false;
  }

  if (!RegExp('[a-z0-9]+@[a-z]+\\.[a-z]{2,3}').hasMatch(email)) {
   Get.snackbar(
        "OOps..! It Seems Like You have made a mistake",
        "your Email is Badly Formated",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    return false;
  }

  return true;
}

bool _isValidPassword() {
  String password = passwordController.text.trim();

  if (password.isEmpty) {
    Get.snackbar(
        "OOps..! It Seems Like You have made a mistake",
        "your Password is empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    return false;
  }

  if(password.length <= 6)
  {
    Get.snackbar(
        "OOps..! It Seems Like You have made a mistake",
        "your Password must be greater than 6 characters",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    return false;  
  }

  return true;
}


  void signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Get.offAll(() => VerifiedPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
        "No User Found With That Email",
        "If You are new please register first",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
        "Your Password doesn't match with our credentials",
        "If You are new please register first",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    if (FirebaseAuth.instance.currentUser != null) {
      Get.offAll(() => VerifiedPage());
    }

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();

    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  }
}
