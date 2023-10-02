import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDisplay extends StatefulWidget {
  final String friendUserId;
  final String senderUserId;
  
  MessageDisplay({required this.friendUserId,required this.senderUserId});

  @override
  _MessageDisplayState createState() => _MessageDisplayState();
}

class _MessageDisplayState extends State<MessageDisplay> {
  List<Map<String, dynamic>> messages = [];
  
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAndSetMessages();
  }

  Future<void> fetchAndSetMessages() async {
    try {
      final chatCollection = FirebaseFirestore.instance.collection('Chats');
      final querySnapshot = await chatCollection
          .where('Receiver', isEqualTo: widget.friendUserId)
          .get();

      final fetchedMessages = querySnapshot.docs
          .map((doc) => doc.data())
          .toList();

      setState(() {
        messages = fetchedMessages;
      });
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  Future<String> fetchSenderName(String senderId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(senderId)
          .get();

      final userData = userDoc.data() as Map<String, dynamic>;
      final firstName = userData['firstName'] as String;
      return firstName;
    } catch (e) {
      print('Error fetching sender name: $e');
      return 'Unknown';
    }
  }

  List<String> extractMessageTexts(Map<String, dynamic> messageMap) {
    List<String> messageTexts = [];

    if (messageMap.containsKey('Messages')) {
      final messages = messageMap['Messages'] as Map<String, dynamic>;
      for (var entry in messages.entries) {
        final messageData = entry.value as Map<String, dynamic>;
        if (messageData.containsKey('messageText')) {
          final messageText = messageData['messageText'] as String;
          messageTexts.add(messageText);
        }
      }
    }

    return messageTexts;
  }

  List<Widget> buildMessageGroups() {
    Map<String, List<Map<String, dynamic>>> messageGroups = {};

    for (var message in messages) {
      final messageTexts = extractMessageTexts(message);
      final timestamp = messageTexts.isNotEmpty ? messageTexts[0] : '';

      if (!messageGroups.containsKey(timestamp)) {
        messageGroups[timestamp] = [];
      }

      messageGroups[timestamp]!.add(message);
    }

    List<Widget> messageGroupWidgets = [];

    messageGroups.forEach((timestamp, groupMessages) {
      messageGroupWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                timestamp,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            for (var message in groupMessages)
              FutureBuilder<String>(
                future: fetchSenderName(message['Sender']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final senderName = snapshot.data!;
                    final isYou = message['Sender'] == widget.friendUserId;

                    return Align(
                      alignment: isYou
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: isYou ? Colors.blue : Colors.green,
                          borderRadius: BorderRadius.only(
                            topLeft: isYou
                                ? Radius.circular(16.0)
                                : Radius.circular(0.0),
                            topRight: isYou
                                ? Radius.circular(0.0)
                                : Radius.circular(16.0),
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0),
                          ),
                        ),
                        child: Text(
                          message['Sender'] == widget.friendUserId
                              ? 'You: ${extractMessageTexts(message).join(', ')}'
                              : '$senderName: ${extractMessageTexts(message).join(', ')}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Text('Loading...');
                  }
                },
              ),
          ],
        ),
      );
    });

    return messageGroupWidgets;
  }

  Future<void> sendMessage({
     required String senderId,
     required String receiverId,
  }) async {
   
    final messageText = messageController.text;
    if (messageText.isNotEmpty) {
      final chatCollection = FirebaseFirestore.instance.collection('Chats');
      
      // Check if a chat document already exists between sender and receiver
      final existingChatQuery = await chatCollection
          .where('Sender', isEqualTo: senderUserId)
          .where('Receiver', isEqualTo: widget.friendUserId)
          .get();

      if (existingChatQuery.docs.isNotEmpty) {
        // Chat document already exists, update it
        final existingChatDoc = existingChatQuery.docs.first;
        final messageField = existingChatDoc.data()['Messages'] as Map<String, dynamic>;

        // Add the new message with a unique timestamp
        final timestamp = Timestamp.now().millisecondsSinceEpoch.toString();
        messageField[timestamp] = {
          'messageText': messageText,
          'TimeStamp': FieldValue.serverTimestamp(),
        };

        // Update the existing chat document
        await existingChatDoc.reference.update({'Messages': messageField});
      } else {
        // Chat document does not exist, create a new one
        final newMessage = {
          'Sender': widget.friendUserId,
          'Receiver': widget.friendUserId, // Set the receiver ID
          'Messages': {
            Timestamp.now().millisecondsSinceEpoch.toString(): {
              'messageText': messageText,
              'TimeStamp': FieldValue.serverTimestamp(),
            },
          },
        };

        // Create a new chat document
        await chatCollection.add(newMessage);
      }

      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Friend'), // Replace with the friend's name
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true, // To show the latest messages at the bottom
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildMessageGroups(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage(receiverId: widget.friendUserId,senderId:senderUserId ), // Send the message
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
