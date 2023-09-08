import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) {
    _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
            () => Get.snackbar("Success", 'Your Accont has been created'))
        .catchError((error, StackTrace) {
      Get.snackbar("erorr", "Something went wrong please try again");
    });
  }
}
