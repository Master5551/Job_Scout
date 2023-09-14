// import 'package:flutter/material.dart';
// import 'package:job_scout/Home/welcome_screen.dart';
// import '../../components/bottom_navigation.dart'; 

// class JobsScreen extends StatefulWidget {
//   const JobsScreen({super.key});

//   @override
//   State<JobsScreen> createState() => _JobsScreenState();
// }

// class _JobsScreenState extends State<JobsScreen> {
//   int _currentIndex = 3; // Set the initial index to 0 for the "Home" button

//   void _onTap(int index) {
//     if (index == 0) {
//       // If "Home" button is tapped
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => WelcomeScreen()),
//       );
//     } else if (index == 3) {
//       // If "Jobs" button is tapped
//       Navigator.popUntil(context, ModalRoute.withName('/'));
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => JobsScreen()),
//       );
//     } else {
//       setState(() {
//         _currentIndex = index;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           'Jobs',
//           style: TextStyle(
//             color: Colors.grey[800],
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 // Navigate to job description page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => JobDescriptionPage()),
//                 );
//               },
//               child: JobCard(
//                 companyName: 'Facebook', 
//                 jobRole: 'SDE-2',
//                 logoUrl: 'https://example.com/logo.png', 
//                 salary: '\$50000',
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 // Navigate to job description page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => JobDescriptionPage()),
//                 );
//               },
//               child: JobCard(
//                 companyName: 'Google',
//                 jobRole: 'SDE-1',
//                 logoUrl: 'https://example.com/logo.png', 
//                 salary: '\$60000',
//               ),
//             ),
//             // Add more GestureDetector instances as needed
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigation(
//         currentIndex: _currentIndex,
//         onTap: _onTap,
//       ),
//     );
//   }
// }

// class JobCard extends StatelessWidget {
//   final String companyName;
//   final String jobRole;
//   final String logoUrl;
//   final String salary;

//   const JobCard({
//     required this.companyName,
//     required this.jobRole,
//     required this.logoUrl,
//     required this.salary,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       child: ListTile(
//         leading: Image.network(
//           logoUrl,
//           width: 60, // Adjust logo width as needed
//         ),
//         title: Text(
//           companyName,
//           style: TextStyle(
//             fontWeight: FontWeight.bold, // Make the company name bold
//             fontSize: 18, // Adjust font size as needed
//           ),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(jobRole),
//             SizedBox(height: 8),
//             Text('Salary: $salary'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class JobDescriptionPage extends StatefulWidget {
//   @override
//   State<JobDescriptionPage> createState() => _JobDescriptionPageState();
// }

// class _JobDescriptionPageState extends State<JobDescriptionPage> {
//   int _currentIndex = 3; // Set the initial index to 0 for the "Home" button

//   void _onTap(int index) {
//     if (index == 0) {
//       // If "Home" button is tapped
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => WelcomeScreen()),
//       );
//     } else {
//       setState(() {
//         _currentIndex = index;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Job Description'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(20),
//               child: Text(
//                 'Software Development Engineer (SDE-1) at Google\n\n'
//                 'Job Description:\n'
//                 'As a Software Development Engineer (SDE-1) at Google, you will work '
//                 'on designing, developing, testing, and deploying high-quality software '
//                 'solutions. You will collaborate with cross-functional teams to deliver '
//                 'innovative products that meet customer needs. You will be responsible '
//                 'for writing clean and efficient code, troubleshooting issues, and '
//                 'contributing to the growth of Google\'s technology ecosystem.\n\n'
//                 'Qualifications:\n'
//                 '- Bachelor\'s degree in Computer Science or related field\n'
//                 '- Strong programming skills in languages such as Java, C++, or Python\n'
//                 '- Familiarity with software development methodologies and best practices\n'
//                 '- Excellent problem-solving and communication skills\n'
//                 '- Ability to work in a fast-paced and collaborative environment\n\n'
//                 'Responsibilities:\n'
//                 '- Design and implement software applications and features\n'
//                 '- Collaborate with product managers, designers, and engineers\n'
//                 '- Write unit and integration tests to ensure code quality\n'
//                 '- Participate in code reviews and provide constructive feedback\n'
//                 '- Continuously improve software performance and scalability\n\n'
//                 'Join us in shaping the future of technology and making an impact at '
//                 'Google!',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle Apply button tap
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Set button size
//                 ),
//                 child: Text(
//                   'Apply',
//                   style: TextStyle(fontSize: 18), // Set font size
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle Save button tap
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Set button size
//                   primary: Colors.white, // Set background color to white
//                   onPrimary: Colors.blue, // Set font color to blue
//                 ),
//                 child: Text(
//                   'Save',
//                   style: TextStyle(fontSize: 18), // Set font size
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }