import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Admin_Module/Upload_pdf/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PdfViewerView extends StatelessWidget {
  final PdfViewerController controller = Get.put(PdfViewerController());
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize Firebase Authentication

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer and Uploader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final User? user = _auth.currentUser; // Get the current user
                if (user != null) {
                  controller.pickPdf(); // Call the function to pick and upload PDF
                } else {
                  print("User not signed in.");
                }
              },
              child: Text('Pick and Upload PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
