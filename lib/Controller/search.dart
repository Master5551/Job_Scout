import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Another extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchUsersPage(),
    );
  }
}

class SearchUsersPage extends StatefulWidget {
  @override
  _SearchUsersPageState createState() => _SearchUsersPageState();
}

class _SearchUsersPageState extends State<SearchUsersPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    try {
      // Print the search query and field being used
      print('Searching for users with query: $query in "firstName" or "lastName" field');

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('firstName', isEqualTo: query)
          .get();

      final querySnapshotLastName = await FirebaseFirestore.instance
          .collection('Users')
          .where('lastName', isEqualTo: query)
          .get();

      final List<Map<String, dynamic>> searchResults = [];

      querySnapshot.docs.forEach((doc) {
        final userData = doc.data() as Map<String, dynamic>;
        searchResults.add(userData);
      });

      querySnapshotLastName.docs.forEach((doc) {
        final userData = doc.data() as Map<String, dynamic>;
        searchResults.add(userData);
      });

      // Print the query results
      print('Query results: $searchResults');

      return searchResults;
    } catch (e) {
      print('Error searching for users: $e');
      return [];
    }
  }

  void onSearchButtonPressed() async {
    final searchQuery = _searchController.text;

    if (searchQuery.isNotEmpty) {
      // Print the search query before initiating the search
      print('Initiating search with query: $searchQuery');

      final results = await searchUsers(searchQuery);

      setState(() {
        _searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by First or Last Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: onSearchButtonPressed,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text('No results found'),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final user = _searchResults[index];
        
        // Check if user data is null
        if (user == null) {
          return ListTile(
            title: Text('User data not found'),
          );
        }

        // Access user data properties
        final firstName = user['firstName'] ?? 'Unknown';
        final lastName = user['lastName'] ?? 'Unknown';
        final email = user['email'] ?? 'Unknown';

        return ListTile(
          title: Text('$firstName $lastName'),
          subtitle: Text(email),
          onTap: () {
            // You can navigate to the user's profile page here
            // Replace this with your navigation logic
          },
        );
      },
    );
  }
}
