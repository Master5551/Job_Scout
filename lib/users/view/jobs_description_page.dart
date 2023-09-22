import 'package:flutter/material.dart';

class JobDescriptionPage extends StatefulWidget {
  @override
  State<JobDescriptionPage> createState() => _JobDescriptionPageState();
}

class _JobDescriptionPageState extends State<JobDescriptionPage> {
  int _currentIndex = 3; // Set the initial index to 0 for the "Home" button

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Description'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Text(
                'Software Development Engineer (SDE-1) at Google\n\n'
                'Job Description:\n'
                'As a Software Development Engineer (SDE-1) at Google, you will work '
                'on designing, developing, testing, and deploying high-quality software '
                'solutions. You will collaborate with cross-functional teams to deliver '
                'innovative products that meet customer needs. You will be responsible '
                'for writing clean and efficient code, troubleshooting issues, and '
                'contributing to the growth of Google\'s technology ecosystem.\n\n'
                'Qualifications:\n'
                '- Bachelor\'s degree in Computer Science or related field\n'
                '- Strong programming skills in languages such as Java, C++, or Python\n'
                '- Familiarity with software development methodologies and best practices\n'
                '- Excellent problem-solving and communication skills\n'
                '- Ability to work in a fast-paced and collaborative environment\n\n'
                'Responsibilities:\n'
                '- Design and implement software applications and features\n'
                '- Collaborate with product managers, designers, and engineers\n'
                '- Write unit and integration tests to ensure code quality\n'
                '- Participate in code reviews and provide constructive feedback\n'
                '- Continuously improve software performance and scalability\n\n'
                'Join us in shaping the future of technology and making an impact at '
                'Google!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle Apply button tap
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Set button size
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(fontSize: 18), // Set font size
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Save button tap
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Set button size
                  primary: Colors.white, // Set background color to white
                  onPrimary: Colors.blue, // Set font color to blue
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18), // Set font size
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}