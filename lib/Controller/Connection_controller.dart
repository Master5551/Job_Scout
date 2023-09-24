import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> printUserIdsFromConnections(String currentUserId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final connectionSnapshot = await firestore
      .collection('Users')
      .doc(currentUserId)
      .collection('Connections')
      .get();

  for (final doc in connectionSnapshot.docs) {
    final userId = doc.get(FieldPath(const ['userID']));
    print('User ID: $userId');
  }
}
// Future<void> printUserDetailsFromUsersCollection(List<String> userIds) async {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   for (final userId in userIds) {
//     final userSnapshot = await firestore.collection('Users').doc(userId).get();

//     if (userSnapshot.exists) {
//       final userData = userSnapshot.data() as Map<String, dynamic>;
//       print('User ID: $userId');
//       print('First Name: ${userData['firstName']}');
//       print('Last Name: ${userData['lastName']}');
//       print('Email: ${userData['email']}');
//       // Print other user details as needed
//     } else {
//       print('User with ID $userId not found in the Users collection');
//     }
//   }
// }

// Future<List<String>> fetchChatUsers(String currentUserId) async {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final DocumentSnapshot connectionSnapshot =
//       await firestore.collection('Users').doc(currentUserId).get();

//   final connectionData = connectionSnapshot.data() as Map<String, dynamic>;
  
//   final connectionUserIds = <String>[];
  
//   if (connectionData.containsKey('Connections')) {
//     final connections = connectionData['Connections'] as List<dynamic>;
    
//     for (final connection in connections) {
//       if (connection is Map<String, dynamic> && connection.containsKey('userID')) {
//         final userId = connection['UserID'] as String;
//         connectionUserIds.add(userId);
//       }
//     }
//   }

//   print('Connection User IDs: $connectionUserIds'); // Print the user IDs

  // return connectionUserIds;
// }