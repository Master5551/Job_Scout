import 'package:flutter/material.dart';
import 'package:job_scout/models/user_data.dart';
import 'package:job_scout/services/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserListScreen extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: userRepository.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<UserModel> users = snapshot.data ?? [];

            // Get the UID of the current user
            String currentUserId = _auth.currentUser?.uid ?? "";

            // Find the details of the current user
            UserModel currentUser = users.firstWhere(
              (user) => user.userId == currentUserId,
              orElse: () => UserModel(
                userId: "",
                firstName: "",
                email: "", 
                lastName: '', 
                mobileNumber: '', 
                profession: '', 
                title: '', 
                about: '', 
                dob: '',
                // Add other default values as needed
              ),
            );

            

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                
              ],
            );
          }
        },
      ),
    );
  }
}
