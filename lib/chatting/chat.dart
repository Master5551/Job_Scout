import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  final String friendUserId; 

  ChatPage({required this.friendUserId});

  Future<String> fetchFriendName(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users') // Replace with your Firebase user collection name
          .doc(userId)
          .get();

      final userData = userDoc.data() as Map<String, dynamic>;
      final firstName = userData['firstName'] as String;

      return firstName;
    } catch (e) {
      print('Error fetching friend name: $e');
      return 'Unknown';
    }
  }

 Future<List<String>> fetchMessages(String friendUserId) async {
  try {
    final chatCollection = FirebaseFirestore.instance.collection('Chats');
    final querySnapshot = await chatCollection
        .where('Receiver', isEqualTo: friendUserId)
        .get();

    final messages = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .map((data) => data['Messages']['messageText'] as String)
        .toList();

    return messages;
  } catch (e) {
    print('Error fetching messages: $e');
    return [];
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: fetchFriendName(friendUserId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final friendName = snapshot.data;
               return Text(friendName!);
            } else {
              return Text('Loading...');
            }
          },
        ),
      ),
      body: FutureBuilder<List<String>>(
  future: fetchMessages(friendUserId),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (snapshot.hasData) {
      final messages = snapshot.data;

      return ListView.builder(
        itemCount: messages?.length,
        itemBuilder: (context, index) {
          final messageText = messages?[index];
          return ListTile(
            title: Text(messageText ?? ''),
            // Customize how you want to display the message
          );
        },
      );
    } else {
      return Text('No messages.');
    }
  },
),

    );
  }
}

Future<List<Map<String, dynamic>>> fetchMessages(String friendUserId) async {
  try {
    final chatCollection = FirebaseFirestore.instance.collection('Chat');
    final querySnapshot = await chatCollection
        .where('Receiver', isEqualTo: friendUserId)
        .get();

    final messages = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    return messages;
  } catch (e) {
    print('Error fetching messages: $e');
    return [];
  }
}
