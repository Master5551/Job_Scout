import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/User_Module/Controller/company_controller.dart';

class JobPostListPage extends StatelessWidget {
  final CompanyController companyController = Get.find<CompanyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Posts'),
      ),
      body: GetBuilder<CompanyController>(
        init: companyController,
        builder: (_) {
          return ListView.builder(
            itemCount: companyController.jobPosts.length,
            itemBuilder: (context, index) {
              var jobPost = companyController.jobPosts[index];
              return Card(
                child: ListTile(
                  title: Text(jobPost['companyName']),
                  subtitle: Text(jobPost['companyType']),
                  
                ),
              );
            },
          );
        },
      ),
    );
  }
}
