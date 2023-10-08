import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        users.assignAll(querySnapshot.docs.map((doc) => doc.data()));
      } else {
        users.clear();
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }
}
