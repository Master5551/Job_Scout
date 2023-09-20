import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  // Method to log out the user
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error during logout: $e");
    }
  }
}
