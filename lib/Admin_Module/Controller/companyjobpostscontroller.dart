import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_scout/Admin_Module/View/Pages/appliedusers.dart';
import 'package:job_scout/User_Module/View/Authentication/Login_page/login_page.dart';

class CompanyJobPostsController extends GetxController {
  RxList<QueryDocumentSnapshot> jobPosts = <QueryDocumentSnapshot>[].obs;
    final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> getJobPosts(String companyId) async {
    try {
      QuerySnapshot jobPostsSnapshot = await FirebaseFirestore.instance
          .collection('Company')
          .doc(companyId)
          .collection('Jobpost')
          .get();

      jobPosts.assignAll(jobPostsSnapshot.docs);
    } catch (e) {
      // Handle error
      print('Error fetching job posts: $e');
    }
  }

  Future<void> logoutAndRedirectToLogin() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      Get.off(LoginPage()); 
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  void navigateToAppliedUsersView(String jobPostId, String companyId) {
    Get.to(() => AppliedUsersView(jobPostId: jobPostId, companyId: companyId));
  }
}
