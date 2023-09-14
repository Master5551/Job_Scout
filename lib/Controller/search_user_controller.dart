import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUsersController extends GetxController {
  final searchController = TextEditingController();
  final searchResults = RxList<Map<String, dynamic>>([]);
  final isLoading = false.obs;
  RxInt currentIndex = 2.obs;

  Future<void> searchUsers() async {
    try {
      final query = searchController.text;
      if (query.isEmpty) {
        return;
      }

      isLoading.value = true;

      // Perform your Firestore query here and update searchResults

      isLoading.value = false;
    } catch (e) {
      print('Error searching for users: $e');
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}