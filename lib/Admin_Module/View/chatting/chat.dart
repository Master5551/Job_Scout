import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;

  Future<void> fetchUsersData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('Users').get();

      // Clear existing users before updating the list
      users.clear();

      // Iterate over each document and add it to the users list
      snapshot.docs.forEach((doc) {
        users.add(doc.data());
      });

      // Print each user document
      users.forEach((user) {
        print('User: $user');
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }
  String getFirstNameByUid(String uid) {
    final user = users.firstWhere((user) => user['uid'] == uid, orElse: () => {});
    return user != null ? user['firstName'] ?? '' : '';
  }

  String getCurrentUserUid() {
    // Fetch the current user's UID from FirebaseAuth
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser?.uid ?? '';
  }
}

class UserScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await userController.fetchUsersData();
              },
              child: Text('Fetch Users'),
            ),
            Obx(() {
              final currentUserID = userController.getCurrentUserUid();

              // Filter out the current user's document
              final otherUsers = userController.users
              
              
                  .where((user) => user['uid'] != currentUserID)
                  .toList();

              return Expanded(
                child: ListView.builder(
                  itemCount: otherUsers.length,
                  itemBuilder: (context, index) {
                    final user = otherUsers[index];
                    final uid = user['uid'];
                    final firstName =
                        userController.getFirstNameByUid(uid);

                    // Additional null checks
                    if (uid != null && firstName != null) {
                      return ListTile(
                        title: Text(firstName),
                        subtitle: Text('UID: $uid'),
                      );
                    } else {
                      return SizedBox.shrink(); // Placeholder for handling null values
                    }
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
