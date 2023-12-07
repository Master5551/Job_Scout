import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyController extends GetxController {
  RxList<String> companyIds = <String>[].obs;
  RxList<Map<String, dynamic>> jobPosts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setCompanyIds(List<String> ids) async {
    companyIds.assignAll(ids);
  }

  Future<void> addAppliedCompanyId(String id, String userId) async {
    companyIds.add(id);
    findthejobpostID(id);
  }

  Future<void> findthejobpostID(String jobpostId) async {
    try {
      List<Map<String, dynamic>> fetchedJobPosts = [];

      // Get all companies
      QuerySnapshot companiesSnapshot =
          await FirebaseFirestore.instance.collection('Company').get();

      // Iterate through each company
      for (QueryDocumentSnapshot companyDoc in companiesSnapshot.docs) {
        // Access the jobpost subcollection for each company
        QuerySnapshot jobpostSnapshot =
            await companyDoc.reference.collection('Jobpost').get();

        // Iterate through each jobpost document and store its data
        for (QueryDocumentSnapshot jobpostDoc in jobpostSnapshot.docs) {
          if (jobpostId == jobpostDoc.id) {
            fetchedJobPosts.add(jobpostDoc.data() as Map<String, dynamic>);
          }
        }
      }

      // Update the jobPosts list in the controller after fetching all data
      jobPosts.assignAll(fetchedJobPosts);
    } catch (e) {
      print('Error: $e');
    }
  }
}
