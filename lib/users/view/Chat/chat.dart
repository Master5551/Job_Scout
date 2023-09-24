import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsScreen1 extends StatefulWidget {
  final List<String> chatUserIds;

  ChatsScreen1({required this.chatUserIds});

  @override
  _ChatsScreen1State createState() => _ChatsScreen1State();
}

class _ChatsScreen1State extends State<ChatsScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: ListView.builder(
        itemCount: widget.chatUserIds.length,
        itemBuilder: (context, index) {
          final userId = widget.chatUserIds[index];
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('Users').doc(userId).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
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
