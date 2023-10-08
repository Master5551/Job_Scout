import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  Set<int> selectedIndexes = Set<int>();
  bool removeButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicants List'),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            final users = snapshot.data!.docs;

            return Column(
              children: [
                ElevatedButton(
                  onPressed: removeButtonEnabled
                      ? () {
                          // Handle the removal of selected cards
                          setState(() {
                            selectedIndexes.forEach((index) {
                              // Implement the removal logic here
                              // For example, remove user at index users[index]
                              // users.removeAt(index);
                            });
                            selectedIndexes.clear();
                            removeButtonEnabled = false;
                          });
                        }
                      : null, // Disable the button if nothing is selected
                  child: Text('Remove Selected'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index].data() as Map<String, dynamic>;

                      return InkWell(
                        onLongPress: () {
                          setState(() {
                            // Toggle selection for the card at the given index
                            if (selectedIndexes.contains(index)) {
                              selectedIndexes.remove(index);
                            } else {
                              selectedIndexes.add(index);
                            }
                            // Enable the "Remove Selected" button if there are selected cards
                            removeButtonEnabled = selectedIndexes.isNotEmpty;
                          });
                        },
                        child: Card(
                          margin: EdgeInsets.all(8.0),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            title: Text(
                              user['firstName'] ?? 'Name not available',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            subtitle: Text(
                              user['email'] ?? 'Email not available',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                user['firstName'][0],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                            trailing: selectedIndexes.contains(index)
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 24.0,
                                  )
                                : null, // Show the check icon for selected cards
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
