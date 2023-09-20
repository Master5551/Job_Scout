import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/users/Authentication/register_page.dart';
import 'login_page.dart'; 
import 'package:flutter_svg/flutter_svg.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a custom green color similar to green[400]
    final customGreenColor = Colors.green.shade400;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SvgPicture.asset(
                'assets/images/startpage.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: customGreenColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/register');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(customGreenColor),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
