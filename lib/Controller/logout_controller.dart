import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_scout/users/Authentication/login_page.dart';

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
      Get.to(LoginPage());
      
    } catch (e) {
      print("Error during logout: $e");
    }
  }

 
  Future<void> googleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      
      // Redirect to the login page
      Get.to(LoginPage()); 
    } catch (e) {
      print("Error during Google sign out: $e");
    }
  }
}
