import 'package:flutter/material.dart';
import 'package:job_scout/components/my_button.dart';
import 'package:job_scout/components/my_text_field.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  // text editing controller
  final userNameController = TextEditingController();
  final PasswordController = TextEditingController();

  // sign in user method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Icon(
            Icons.lock,
            size: 100,
          ),
          SizedBox(
            height: 50,
          ),

          Text(
            'Welcome to Job Scout App',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 50,
          ),

          // Username textfield
          MyTextField(
            controller: userNameController,
            hinText: 'Enter your Username here',
            obsecureText: false,
          ),
          SizedBox(
            height: 50,
          ),

          //password textfield
          MyTextField(
            controller: PasswordController,
            hinText: 'Enter your password here',
            obsecureText: true,
          ),

          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot_Password',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              )),

          SizedBox(height: 25),

          MyButton(
            onTap: signUserIn,
          ),

          SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade400,
                  ),
                ),
                Text('Or Continue with'),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              SignInButton(
              Buttons.Google,
              onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
