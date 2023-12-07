import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Admin_Module/Controller/applieduserscontroller.dart';
import 'package:job_scout/Admin_Module/View/Pages/show_profile.dart';
  
class AppliedUsersView extends StatelessWidget {
  final String jobPostId;
  final String companyId;
  final AppliedUsersController _controller = Get.put(AppliedUsersController());

  AppliedUsersView({required this.jobPostId, required this.companyId});

  @override
  Widget build(BuildContext context) {
    // Call getAppliedUsers when the view is built
    _controller.getAppliedUsers(companyId, jobPostId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Applied Users'),
        backgroundColor: Colors.orange,
      ),
      body: Obx(() {
        if (_controller.appliedUsers.isEmpty) {
          return CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: _controller.appliedUsers.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> userData =
                  _controller.appliedUsers[index].data() as Map<String, dynamic>;
              String userId = _controller.appliedUsers[index].id;

              return Dismissible(
                key: Key(userId),
                onDismissed: (direction) {
                  // Delete document when dismissed
                  _controller.deleteAppliedUser(companyId, userId, jobPostId);
                },
                background: Container(
                  color: Colors.orange,
                  child: Icon(Icons.delete, color: Colors.white),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.0),
                ),
                child: Card(
                // Light orange background
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('User ID: $userId'),
                    subtitle: Text('User Data: $userData'),
                    // Add more ListTile properties or widgets as needed
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            // Handle "Tick" action
                            // You can add your logic here
                            print("Tick pressed");
                            print(userData['userId']);
                            // Get.to(UserIDPage(userData[0]));
                            Get.to(UserIDPage(userData['userId']));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            // Handle "Wrong" action
                            // You can add your logic here
                            _controller.deleteAppliedUser(companyId, userId, jobPostId);
                            _controller.getAppliedUsers(companyId, jobPostId);
                            print("Wrong pressed");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
