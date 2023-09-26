import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_scout/Controller/Connection_controller_final.dart';

class ChatsScreen1 extends StatefulWidget {
  final String currentUserId;

  ChatsScreen1({required this.currentUserId});

  @override
  _ChatsScreen1State createState() => _ChatsScreen1State();
}

class _ChatsScreen1State extends State<ChatsScreen1> {
  @override
  void initState() {
    super.initState();
    loadUserIds();
  }

  Set<String> userIds = {}; // Use a Set to ensure uniqueness

  Future<void> loadUserIds() async {
    final loadedUserIds = await getUserIdsFromConnections(widget.currentUserId);

    // Remove the currentUserId from the loadedUserIds set
    loadedUserIds.remove(widget.currentUserId);

    userIds = loadedUserIds.toSet(); // Convert to Set to ensure uniqueness
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: userIds.isEmpty
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: userIds.length,
              itemBuilder: (context, index) {
                final friendUserId = userIds.elementAt(index);
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(friendUserId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final firstName = userData['firstName'] ?? '';
                      final lastName = userData['lastName'] ?? '';
                      final email = userData['email'] ?? '';

                      return ListTile(
                        title: Text('$firstName $lastName'),
                        subtitle: Text(email),
                        onTap: () {
                          // Implement navigation to chat with this user
                        },
                      );
                    } else {
                      return Text('User not found');
                    }
                  },
                );
              },
            ),
    );
  }
}
