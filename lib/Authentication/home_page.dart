import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/startpage.png', // Replace with your image asset path
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Row(
              children: [
                Text(
                  'Next',
                  style: TextStyle(
                    color:
                        Colors.green[800], // Set the text color to light green
                    fontSize: 18, // Adjust the font size as needed
                  ),
                ),
                SizedBox(
                    width: 10), // Add some space between the text and the icon
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
