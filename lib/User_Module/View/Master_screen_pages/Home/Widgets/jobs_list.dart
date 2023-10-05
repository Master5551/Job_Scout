import 'package:flutter/material.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Home/Widgets/jobs_item.dart';
import 'package:job_scout/User_Module/models/job.dart';

class JobsList extends StatelessWidget {
  final jobList = Job.generateJobs();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 25), // Add some spacing at the top
              ListView.separated(
                shrinkWrap: true, // Allow the inner ListView to take as much height as needed
                padding: EdgeInsets.zero, // Remove extra padding
                physics: NeverScrollableScrollPhysics(), // Disable scrolling for this inner ListView
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => JobsItem(jobList[index]),
                separatorBuilder: (_, index) => SizedBox(
                  height: 15,
                ),
                itemCount: jobList.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
