import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_scout/User_Module/View/Before_master_page/new_user_page.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/profile_page.dart';
import 'package:job_scout/User_Module/components/bottom_navigation.dart';

class UserStateController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId;
  bool hasDetails = false;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeUserDetails();
    _isInitialized = true;
  }

  Future<void> _initializeUserDetails() async {
    userId = _auth.currentUser?.uid ?? "";
    hasDetails = await checkUserDetails(userId);

    if (hasDetails == false) {
      Get.to(NewUserPage());
    } else {
      Get.to(BottomNavBar());
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

        if (userData.containsKey('firstname') &&
            userData.containsKey('lastname')) {
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
}
