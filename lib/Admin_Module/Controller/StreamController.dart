import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StreamController extends GetxController {
  final RxList<DocumentSnapshot<Map<String, dynamic>>> documents =
      <DocumentSnapshot<Map<String, dynamic>>>[].obs;

  Future<String?> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Future<void> searchAndApply(String companyName, String documentId) async {
    CollectionReference<Map<String, dynamic>> companiesCollection =
        FirebaseFirestore.instance.collection('Company');

    QuerySnapshot<Map<String, dynamic>> companyQuerySnapshot =
        await companiesCollection.where('Name', isEqualTo: companyName).get();

    if (companyQuerySnapshot.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> companyDocument =
          companyQuerySnapshot.docs.first;

      CollectionReference<Map<String, dynamic>> jobPostsCollection =
          companyDocument.reference.collection('Jobpost');

      QuerySnapshot<Map<String, dynamic>> jobPostsQuerySnapshot =
          await jobPostsCollection.get();

      DocumentSnapshot<Map<String, dynamic>> clickedDocument = jobPostsQuerySnapshot.docs
          .firstWhere((jobPostDocument) =>
              jobPostDocument.id == documentId &&
              jobPostDocument.data()['companyName'] == companyName,
          );

      if (clickedDocument != null) {
        Map<String, dynamic> clickedJobPostData =
            clickedDocument.data() as Map<String, dynamic>;

        CollectionReference<Map<String, dynamic>> appliedUsersCollection =
            clickedDocument.reference.collection('Applied_Users');

        String? currentUserId = await getCurrentUserId();
        if (currentUserId != null) {
          await appliedUsersCollection.add({'userId': currentUserId});
          applyToCompany(currentUserId, companyName);
          print(
              'User with UID $currentUserId applied to JobPost with ID: $documentId, Data: $clickedJobPostData');
        } else {
          print('Error: Current user is not signed in');
        }
      } else {
        print(
            'JobPost with ID $documentId and company name $companyName not found');
      }
    } else {
      print('Company with name $companyName not found');
    }
  }

  Future<void> applyToCompany(String userUid, String companyName) async {
    try {
      CollectionReference<Map<String, dynamic>> usersCollection =
          FirebaseFirestore.instance.collection('Users');

      DocumentReference<Map<String, dynamic>> userDocumentRef =
          usersCollection.doc(userUid);

      CollectionReference<Map<String, dynamic>> appliedCompanyCollection =
          userDocumentRef.collection('Applied_company');

      await appliedCompanyCollection.add({'Name': companyName});

      print('User with UID $userUid applied to company $companyName');
    } catch (e) {
      print('Error applying to company: $e');
    }
  }
Future<void> iterateOverAllJobpostSubcollections() async {
    try {
      CollectionReference<Map<String, dynamic>> companiesCollectionRef =
          FirebaseFirestore.instance.collection('Company');

      QuerySnapshot<Map<String, dynamic>> companiesQuerySnapshot =
          await companiesCollectionRef.get();

      for (var companyDocument in companiesQuerySnapshot.docs) {
        CollectionReference<Map<String, dynamic>> jobpostCollectionRef =
            companyDocument.reference.collection('Jobpost');

        QuerySnapshot<Map<String, dynamic>> jobpostQuerySnapshot =
            await jobpostCollectionRef.get();

        for (var jobpostDocument in jobpostQuerySnapshot.docs) {
          // Access each jobpost document here
          print('Company: ${companyDocument.id}, Jobpost: ${jobpostDocument.id}');
          // You can perform additional actions or store the documents as needed
        }
      }
    } catch (e) {
      print('Error iterating over Jobpost subcollections: $e');
    }
  }
    void updateDocuments(List<DocumentSnapshot<Map<String, dynamic>>> newDocuments) {
      documents.assignAll(newDocuments);
      update();
    }

  void clearDocuments() {
    documents.clear();
    update();
  }
}
