import 'package:flutter/material.dart';
import 'package:job_scout/Home/bottom_navigation.dart';
import 'bottom_navigation.dart'; // Import the bottom_navigation.dart file
import 'jobs.dart'; // Import the jobs.dart file

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
   int _currentIndex = 0; // Set the initial index to 0 for the "Home" button

  void _onTap(int index) {
    if (index == 3) {
      // If "Jobs" button is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JobsScreen()),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            color: Color.fromARGB(255, 121, 116, 116),
            icon: Icon(Icons.chat),
            onPressed: () {
              // Add your chat icon button functionality here
            },
          ),
        ],
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
