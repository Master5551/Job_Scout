import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PdfViewerController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Initialize Firestore

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      String? filePath = result.files.single.path;

      if (filePath != null) {
        File file = File(filePath);

        if (file.existsSync()) {
          Uint8List fileBytes = await file.readAsBytes();
          String fileName = result.files.single.name;

          print('File Bytes: $fileBytes');

          final FirebaseStorage storage = FirebaseStorage.instance;

          try {
            TaskSnapshot task = await storage.ref(fileName).putData(fileBytes);
            String downloadURL = await task.ref.getDownloadURL();
            print('Download URL: $downloadURL');

            // Update Firestore with the download URL
            final User? user = _auth.currentUser;
            if (user != null) {
              String userUid = user.uid;
              DocumentReference userDocument = _firestore.collection('Users').doc(userUid);
              userDocument.update({'pdfUrl': downloadURL}).then((_) {
                print('Firestore updated successfully.');
              }).catchError((error) {
                print('Error updating Firestore: $error');
              });
            } else {
              print('User not signed in.');
            }

            print('File uploaded successfully.');
          } catch (e) {
            print('Error uploading file: $e');
          }
        }
      }
    }
  }
}
