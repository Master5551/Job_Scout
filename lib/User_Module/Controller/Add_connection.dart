import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addFriend(String currentUserId, String friendUserId) async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    
    final DocumentReference currentUserRef = firestore.collection('Users').doc(currentUserId);
    final DocumentReference friendUserRef = firestore.collection('Users').doc(friendUserId);

    
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
