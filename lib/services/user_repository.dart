
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_scout/models/user_data.dart';


class UserRepository {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<List<UserModel>> getUsers() async {
    try {
      QuerySnapshot querySnapshot = await usersCollection.get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }
}
