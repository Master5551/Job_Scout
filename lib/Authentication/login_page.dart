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
            hintText: 'Enter your Username here', // Corrected parameter name
            obscureText: false,
          ),
          SizedBox(
            height: 50,
          ),

          //password textfield
          MyTextField(
            controller: userNameController,
            hintText: 'Enter your Password here', // Corrected parameter name
            obscureText: false,
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
          SizedBox(height: 20,),
          Column(
            children: [
              SignInButton(
              Buttons.Google,
              onPressed: () {},),

              SizedBox(height:10),
              
              SignInButton(
              Buttons.Apple,
              onPressed: () {},)
            ],
          ),
          SizedBox(height: 100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not A Member ?"),
              Text("Register Now",
              style: TextStyle(color: Colors.blue),
              )
            ],
          )
        ],
      ),
    );
  }
}
