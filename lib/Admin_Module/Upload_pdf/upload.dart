import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Required for Firebase setup
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PdfViewerScreen(),
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
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

          // Initialize Firebase Storage
          final FirebaseStorage storage = FirebaseStorage.instance;

          // Upload the PDF to Firebase Storage
          try {
            await storage.ref(fileName).putData(fileBytes);
            print('File uploaded successfully.');
          } catch (e) {
            print('Error uploading file: $e');
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer and Uploader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: pickPdf,
              child: Text('Pick and Upload PDF'),
            ),
          ],
        ),
      ),
    );
  }
}