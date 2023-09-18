import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_scout/Controller/search_user_controller.dart';
import 'package:job_scout/components/bottom_navigation.dart';

class SearchUsersPage extends StatelessWidget {
  final SearchUsersController controller = Get.put(SearchUsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                labelText: 'Search by First or Last Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: controller.searchUsers,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.searchResults.isEmpty) {
                  return Center(
                    child: Text('No results found'),
                  );
                }

                return buildSearchResults();
              }),
            ),
          ],
        ),
      ),
//       bottomNavigationBar: BottomNavigation(
//   currentIndex: controller.currentIndex, // Pass the current index
//   tabLabels: ['Home', 'Create', 'Search', 'Profile'], // Pass the labels for each tab
// ),
    );
  }

  Widget buildSearchResults() {
    return ListView.builder(
      itemCount: controller.searchResults.length,
      itemBuilder: (context, index) {
        final user = controller.searchResults[index];

        // Access user data properties
        final firstName = user['firstName'] ?? 'Unknown';
        final lastName = user['lastName'] ?? 'Unknown';
        final email = user['email'] ?? 'Unknown';

        return ListTile(
          title: Text('$firstName $lastName'),
          subtitle: Text(email),
          onTap: () {
            // You can navigate to the user's profile page here
            // Replace this with your navigation logic
          },
        );
      },
    );
  }
}