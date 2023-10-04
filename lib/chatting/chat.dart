import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDisplay extends StatefulWidget {
  final String friendUserId;
  final String senderUserId;

  MessageDisplay({required this.friendUserId, required this.senderUserId});

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

      final fetchedMessages =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        messages = fetchedMessages;
      });
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  Future<List<String>> fetchSenderNames(List<String> senderIds) async {
    List<String> senderNames = [];

    try {
      for (String senderId in senderIds) {
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(senderId)
            .get();

        final userData = userDoc.data() as Map<String, dynamic>;
        final firstName = userData['firstName'] as String;
        senderNames.add(firstName);
      }
      print(senderIds);
      print("Hello");
      return senderNames;
    } catch (e) {
      print('Error fetching sender names: $e');
      return List.generate(senderIds.length, (index) => 'Unknown');
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

  List<String> extractMessageSenderIds(Map<String, dynamic> messageMap) {
    List<String> senderIds = [];

    if (messageMap.containsKey('Messages')) {
      final messages = messageMap['Messages'] as Map<String, dynamic>;
      for (var entry in messages.entries) {
        final messageData = entry.value as Map<String, dynamic>;
        if (messageData.containsKey('ID')) {
          final senderId = messageData['ID'] as String;
          senderIds.add(senderId);
        }
      }
    }

    return senderIds;
  }

  List<Widget> buildMessageGroups() {
    Map<String, List<Map<String, dynamic>>> messageGroups = {};

    for (var message in messages) {
      final messageTexts = extractMessageTexts(message);
      final senderIds = extractMessageSenderIds(message);

      for (var i = 0; i < senderIds.length; i++) {
        final senderId = senderIds[i];
        final messageId = message['Messages'].keys.toList()[i];

        if (!messageGroups.containsKey(messageId)) {
          messageGroups[messageId] = [];
        }

        messageGroups[messageId]!.add({
          'senderId': senderId,
          'messageTexts': messageTexts,
        });
      }
    }

    List<Widget> messageGroupWidgets = [];

    messageGroups.forEach((messageId, groupMessages) {
      messageGroupWidgets.add(
        buildMessageGroup(messageId, groupMessages),
      );
    });

    return messageGroupWidgets;
  }

  Widget buildMessageGroup(
      String messageId, List<Map<String, dynamic>> groupMessages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var message in groupMessages)
          Align(
            alignment: message['senderId'] == widget.senderUserId
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: message['senderId'] == widget.senderUserId
                    ? Colors.blue
                    : Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: message['senderId'] == widget.senderUserId
                      ? Radius.circular(16.0)
                      : Radius.circular(0.0),
                  topRight: message['senderId'] == widget.senderUserId
                      ? Radius.circular(0.0)
                      : Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Text(
                message['senderId'] == widget.senderUserId
                    ? 'You: ${message['messageTexts'].join(', ')}'
                    : '${message['senderId']}: ${message['messageTexts'].join(', ')}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
  }) async {
    final messageText = messageController.text;
    if (messageText.isNotEmpty) {
      final chatCollection = FirebaseFirestore.instance.collection('Chats');

      // Get the document ID for the chat between the sender and receiver
      final chatDocumentId = getChatDocumentId(senderId, receiverId);

      // Check if the chat document already exists
      final existingChatDoc = await chatCollection.doc(chatDocumentId).get();

      if (existingChatDoc.exists) {
        // Chat document already exists, update it
        await updateChatDocument(existingChatDoc, senderId, messageText);
      } else {
        // Chat document does not exist, create a new one
        final newMessage = {
          'Sender': senderId,
          'Receiver': receiverId,
          'Messages': {
            Timestamp.now().millisecondsSinceEpoch.toString(): {
              'ID': senderId,
              'messageText': messageText,
              'TimeStamp': FieldValue.serverTimestamp(),
            },
          },
        };

        // Create a new chat document with the specified document ID
        await chatCollection.doc(chatDocumentId).set(newMessage);
      }

      messageController.clear();
    }
  }

  String getChatDocumentId(String userId1, String userId2) {
    // Generate a unique document ID for the chat document
    // You can use a consistent method to ensure the same ID is generated for both users
    List<String> userIds = [userId1, userId2]..sort();
    return '${userIds[0]}_${userIds[1]}';
  }

  Future<void> updateChatDocument(
    DocumentSnapshot existingChatDoc,
    String senderId,
    String messageText,
  ) async {
    final Map<String, dynamic>? data =
        existingChatDoc.data() as Map<String, dynamic>?;

    if (data != null) {
      final Map<String, dynamic>? messageField =
          data['Messages'] as Map<String, dynamic>?;

      if (messageField != null) {
        // Add the new message with a unique timestamp
        final timestamp = Timestamp.now().millisecondsSinceEpoch.toString();
        messageField[timestamp] = {
          'ID': senderId,
          'messageText': messageText,
          'TimeStamp': FieldValue.serverTimestamp(),
        };

        // Update the existing chat document
        await existingChatDoc.reference.update({'Messages': messageField});
      }
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
              reverse: true,
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
                  onPressed: () async {
                    await sendMessage(
                      senderId: widget.senderUserId,
                      receiverId: widget.friendUserId,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
