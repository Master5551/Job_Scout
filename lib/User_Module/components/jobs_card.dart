import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String companyName;
  final String jobRole;
  final String logoUrl;
  final String salary;

  const JobCard({
    required this.companyName,
    required this.jobRole,
    required this.logoUrl,
    required this.salary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        leading: Image.network(
          logoUrl,
          width: 60, // Adjust logo width as needed
        ),
        title: Text(
          companyName,
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the company name bold
            fontSize: 18, // Adjust font size as needed
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(jobRole),
            SizedBox(height: 8),
            Text('Salary: $salary'),
          ],
        ),
      ),
    );
  }
}