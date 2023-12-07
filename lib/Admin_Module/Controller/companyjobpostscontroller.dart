import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_scout/Admin_Module/View/Pages/appliedusers.dart';

class CompanyJobPostsController extends GetxController {
  RxList<QueryDocumentSnapshot> jobPosts = <QueryDocumentSnapshot>[].obs;

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

  void navigateToAppliedUsersView(String jobPostId, String companyId) {
    Get.to(() => AppliedUsersView(jobPostId: jobPostId, companyId: companyId));
  }
}
