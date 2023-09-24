import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addFriend(String currentUserId, String friendUserId) async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create references to the current user and friend's documents
    final DocumentReference currentUserRef = firestore.collection('Users').doc(currentUserId);
    final DocumentReference friendUserRef = firestore.collection('Users').doc(friendUserId);

    // Create a new document in the "Connection" subcollection with userID and status as false
    await currentUserRef.collection('Connections').doc(friendUserId).set({
      'userID': friendUserId,
      'status':false,
    });

    await friendUserRef.collection('Connections').doc(currentUserId).set({
      'userID': currentUserId,
      'status': false,
    });

    print('Friend added successfully.');
  } catch (e) {
    print('Error adding friend: $e');
  }
}
