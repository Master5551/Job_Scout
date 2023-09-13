import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  late PickedFile? imageFile;
  final ImagePicker imagePicker = ImagePicker();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  void takePhoto(ImageSource source) async {
    // final pickedFile = await imagePicker.getImage(source: source);
    // setState(() {
    //   imageFile = pickedFile;
    // });
  }
}