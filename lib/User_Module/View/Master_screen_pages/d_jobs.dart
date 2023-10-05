import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/User_Module/Controller/jobs_card_controller.dart';
import 'package:job_scout/User_Module/components/jobs_card.dart';
import 'package:job_scout/User_Module/View/Welcome_page/start_page.dart';
import '../../components/bottom_navigation.dart';
import 'd_jobs_description_page.dart';

class JobsScreen extends StatefulWidget {
  JobsScreen({super.key});
  final JobsCardController controller = Get.put(JobsCardController());

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  // Set the initial index to 0 for the "Home" button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Jobs',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to job description page
                Get.to(JobDescriptionPage());
              },
              child: JobCard(
                companyName: 'Facebook',
                jobRole: 'SDE-2',
                logoUrl: 'https://example.com/logo.png',
                salary: '\$50000',
              ),
            ),

            // Add more GestureDetector instances as needed
          ],
        ),
      ),
    );
  }
}
