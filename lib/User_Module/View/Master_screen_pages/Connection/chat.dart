import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListPage extends StatefulWidget {
  final String currentUserId;
  UserListPage({required this.currentUserId});
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<Map<String, dynamic>> usersData = [];
  bool isLoading = true;

  Future<List<String>> getUserIdsFromConnections(String currentUserId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final List<String> userIds = [];

    final connectionSnapshot = await firestore
        .collection('Users')
        .doc(currentUserId)
        .collection('Connections')
        .get();

    for (final doc in connectionSnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('userID')) {
        final userId = data['userID'] as String?;
        if (userId != null) {
          userIds.add(userId);
          print(userId);
        } else {
          userIds.add('DefaultUserID');
        }
      }
    }

    return userIds;
  }

  Future<void> getUserDetails(List<String> userIds) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (final userId in userIds) {
      final userSnapshot =
          await firestore.collection('Users').doc(userId).get();

      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        setState(() {
          usersData.add(userData);
        });
      }
    }
  }

  void initState() {
    super.initState();
    final String currentUserId = widget.currentUserId;
    getUserIdsFromConnections(currentUserId).then((userIds) {
      getUserDetails(userIds).then((_) {}).catchError((error) {
        setState(() {
          isLoading = false;
        });
        print("Error fetching user details: $error");
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching user IDs: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: usersData.length,
        itemBuilder: (BuildContext context, int index) {
          final userData = usersData[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                  'Name: ${userData['firstName']} ${userData['lastName']}'),
              subtitle: Text('Email: ${userData['email']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close),
                    color: Colors.red,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.check),
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
