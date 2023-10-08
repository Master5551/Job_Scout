import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NewUserPage extends StatelessWidget {
  const NewUserPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Lottie.asset(
                'assets/animations/animation_lnh1sb7l.json',
                height: 100,
                reverse: true,
                repeat: true,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10), // Add some spacing between Lottie and Text
              Text(
                "Welcome, To Job Scout",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    'Kindly share some details about yourself to help us find the best job opportunities for you.😊',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height:
                  20), // Add some spacing between the previous text and the input fields

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150, // Set a fixed width or adjust as needed
                    child: TextFormField(
                      // controller: profileController.firstNameController,
                      decoration: InputDecoration(
                        hintText: "First Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        fillColor: Colors.green.shade100,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.person_2,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Add some spacing if needed
                  Container(
                    width: 150, // Set a fixed width or adjust as needed
                    child: TextFormField(
                      // controller: profileController.firstNameController,
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        fillColor: Colors.green.shade100,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.person_2,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              // Second Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300, // Set a fixed width or adjust as needed
                    child: TextFormField(
                      // controller: profileController.firstNameController,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        fillColor: Colors.green.shade100,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Third Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300, // Set a fixed width or adjust as needed
                    child: TextFormField(
                      // controller: profileController.firstNameController,
                      decoration: InputDecoration(
                        hintText: "Enter your Phone number",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        fillColor: Colors.green.shade100,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.phone_android,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors
                      .teal, // Set the button color to match the TextFormField theme
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
