import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppliedUsersController extends GetxController {
  RxList<QueryDocumentSnapshot> appliedUsers = <QueryDocumentSnapshot>[].obs;

  Future<void> getAppliedUsers(String companyId, String jobPostId) async {
    try {
      QuerySnapshot appliedUsersSnapshot = await FirebaseFirestore.instance
          .collection('Company')
          .doc(companyId)
          .collection('Jobpost')
          .doc(jobPostId)
          .collection('Applied_Users')
          .get();

      appliedUsers.assignAll(appliedUsersSnapshot.docs);
    } catch (e) {
      // Handle error 
      print('Error fetching applied users: $e');
    }
  }
  Future<void> deleteAppliedUser(String companyId,String userUid,String jobPostId) async{
    try{
    
        var snapshot= await FirebaseFirestore.instance.collection('Company').doc(companyId).collection('Jobpost').doc(jobPostId).collection('Applied_Users').doc(userUid).get(); 
        if (snapshot.exists) {
  // Access the 'userId' field from the document data
  var userId = snapshot.data()?['userId'];
    await FirebaseFirestore.instance.collection('Company').doc(companyId).collection('Jobpost').doc(jobPostId).collection('Applied_Users').doc(userUid).delete();
        deleteAppliedComapnay(jobPostId, userId);
  // Now, you can use the 'userId' variable as needed
            print('User ID: $userId');
} 
        
        
    }
    catch(e)
    {
      print("Error deleting applied User : $e");
    }
  }
  Future<void> deleteAppliedComapnay(String jobPostId,String userUid) async
  {
      try{
        print("User id = "+userUid);
        print(jobPostId);
    await FirebaseFirestore.instance.collection('Users').doc(userUid).collection('Applied_company').doc(jobPostId).delete();
  }
  catch(e)
  {
    print("Error $e");
  }
  }
 
}
