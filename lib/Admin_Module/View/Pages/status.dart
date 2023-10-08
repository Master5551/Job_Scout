import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Admin_Module/Controller/pdf_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen extends StatelessWidget {
  final Pdfcontroller controller = Get.put(Pdfcontroller());

  PdfViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer and Uploader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                controller.pickpdf();
              },
              child: const Text('Pick and Upload PDF'),
            ),
            const SizedBox(height: 16), // Add some spacing
            Obx(
              () {
                if (controller.filePath.isNotEmpty) {
                  return Expanded(
                    child: SfPdfViewer.asset(
                      controller.filePath.value,
                      key: controller.pdfviewerKey,
                    ),
                  );
                } else {
                  return const Text('No PDF selected');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
