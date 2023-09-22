import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

 
  Future<void> logoutAndRedirectToLogin() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      
      Get.toNamed('/login'); // Replace '/login' with your actual login page route
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  // Method to sign out using Google authentication
  Future<void> googleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      // Redirect to the login page
      Get.toNamed('/login'); 
    } catch (e) {
      print("Error during Google sign out: $e");
    }
  }
}
