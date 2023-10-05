import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserSearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<DocumentSnapshot> searchResults = <DocumentSnapshot>[].obs;
  final RxBool searching = false.obs;
  DocumentSnapshot? lastVisibleResult; // Store the last visible document

  void searchUsers() async {
    final query = searchController.text;
    searching.value = true;

    try {
      final userQuery = await FirebaseFirestore.instance
          .collection('Users')
          .where('firstName', isEqualTo: query)
          .get();

      if (userQuery.docs.isNotEmpty) {
        searchResults.assignAll(userQuery.docs);
        lastVisibleResult =
            userQuery.docs.last; // Store the last visible document
      } else {
        searchResults.clear();
        lastVisibleResult = null; // Reset the last visible document
      }
    } catch (e) {
      print('Error searching users: $e');
    } finally {
      searching.value = false;
    }
  }

  void searchWithBuffer() {
    searching.value = true;
    Future.delayed(Duration(seconds: 2), () {
      searchUsers();
    });
  }

  void showAllResults() async {
  final query = searchController.text;
  searching.value = true;

  try {
    final userQuery = await FirebaseFirestore.instance
        .collection('Users')
        .where('firstName', isEqualTo: query)
        .get();

    if (userQuery.docs.isNotEmpty) {
      searchResults.assignAll(userQuery.docs);
      lastVisibleResult =
          userQuery.docs.last; // Store the last visible document
    } else {
      searchResults.clear();
      lastVisibleResult = null; // Reset the last visible document
    }
  } catch (e) {
    print('Error searching users: $e');
  } finally {
    searching.value = false;
  }
}


  void loadMoreResults() async {
    if (lastVisibleResult == null) {
      return; // No more results to load
    }

    final query = searchController.text;
    searching.value = true;

    try {
      final userQuery = await FirebaseFirestore.instance
          .collection('Users')
          .where('firstName', isEqualTo: query)
          .startAfterDocument(
              lastVisibleResult!) 
          .get();

      if (userQuery.docs.isNotEmpty) {
        searchResults.addAll(userQuery.docs);
        lastVisibleResult =
            userQuery.docs.last; 
      }
    } catch (e) {
      print('Error loading more results: $e');
    } finally {
      searching.value = false;
    }
  }
}
