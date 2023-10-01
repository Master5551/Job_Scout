import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    String? messageText,
  }) async {
    final chatCollection = _firestore.collection('Chats');
    
    final existingChatQuery = await chatCollection
        .where('Sender', isEqualTo: senderId)
        .where('Receiver', isEqualTo: receiverId)
        .get();

    if (existingChatQuery.docs.isEmpty) {
      await chatCollection.add({
        'Sender': senderId,
        'Receiver': receiverId,
        'Messages': {},
      });
    }

    final chatDocument = existingChatQuery.docs.isNotEmpty
        ? existingChatQuery.docs.first.reference
        : null;

    if (chatDocument != null && messageText != null) {
      final currentMessages = await chatDocument.get().then((doc) => doc.data()?['Messages'] ?? {});

      // Create the message map with 'ID,' 'TimeStamp,' and 'messageText'
      final messageMap = {
        'ID': senderId,
        'TimeStamp': FieldValue.serverTimestamp(),
        'messageText': messageText,
      };

      final messageId = DateTime.now().millisecondsSinceEpoch.toString();
      currentMessages[messageId] = messageMap;

      await chatDocument.update({'Messages': currentMessages});
    }
  }
}
