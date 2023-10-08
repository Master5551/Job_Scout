import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final db = FirebaseFirestore.instance;

  get users => null;

  void addNote() async {}
}
