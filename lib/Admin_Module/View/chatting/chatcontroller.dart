 import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;

  Future<void> fetchUsersData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('Users').get();

      users.assignAll(snapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  String getFirstNameByUid(String uid) {
    final user = users.firstWhere((user) => user['uid'] == uid, orElse: () => {});
    return user['firstName'] ?? '';
  }
}
