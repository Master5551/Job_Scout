import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfcontroller extends GetxController {
  final GlobalKey<SfPdfViewerState> pdfviewerKey = GlobalKey();
  final RxString filePath = ''.obs; // Define the filePath property

  @override
  void onInit() {
    super.onInit();
  }

  void pickpdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.first.path!);
      if (file.existsSync()) {
        Uint8List filebytes = await file.readAsBytes();
        String fileName = result.files.first.name;
        print("$filebytes");
        final response = await FirebaseStorage.instance
            .ref('pdfs/$fileName')
            .putData(filebytes);
        print(response.storage.bucket);
        final downloadUrl = await response.ref.getDownloadURL();
        print(downloadUrl);

        // Set the filePath property when the PDF is uploaded
        filePath.value = downloadUrl;
      } else {
        print('Error');
      }
    } else {
      print("Not selected");
    }
  }
}
