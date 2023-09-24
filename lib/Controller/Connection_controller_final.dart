import 'package:cloud_firestore/cloud_firestore.dart';

final List<String> userIds = [];
Future<List<String>> getUserIdsFromConnections(String currentUserId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final connectionSnapshot = await firestore
      .collection('Users')
      .doc(currentUserId)
      .collection('Connections')
      .get();

  for (final doc in connectionSnapshot.docs) {
    final data = doc.data() as Map<String, dynamic>;
    final userId = data['userID'] as String?;
    if (userId != null) {
      userIds.add(userId);
      print(userId);
    } else {
      userIds.add(
          'DefaultUserID'); // Provide a default value if 'userID' is not present
    }
  }

  return userIds;
}

Future<void> printUserDetailsFromUsersCollection(List<String> userIds) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  for (final userId in userIds) {
    final userSnapshot = await firestore.collection('Users').doc(userId).get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      print('User ID: $userId');
      print('First Name: ${userData['firstName']}');
      print('Last Name: ${userData['lastName']}');
      print('Email: ${userData['email']}');
    } else {
      print('User with ID $userId not found in the Users collection');
    }
  }
}

int connectionLength() {
  return userIds.length;
}
