import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_scout/User_Module/Controller/Auth_Controllers/Login_Controller/login_controller.dart';
import 'package:job_scout/User_Module/Controller/logout_controller.dart';
import 'package:job_scout/User_Module/View/Splash_screen/splash_screen.dart';
import 'package:job_scout/User_Module/components/my_button.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:job_scout/User_Module/View/Authentication/Login_page/forgot_password_screen.dart';
import 'package:job_scout/User_Module/View/Authentication/Register_page/register_page.dart';
import 'package:job_scout/User_Module/View/Before_master_page/verified_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final LoginController loginController = Get.put(LoginController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo_1.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.002,
                ),
                Text(
                  'Welcome to Job Scout',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: loginController.emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}')
                          .hasMatch(value)) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Please enter email",
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
                        Icons.mail,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: loginController.passwordController,
                    obscureText: !loginController.isPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        loginController.isPasswordValid.value = true;
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Please enter your password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          loginController.togglePasswordVisibility();
                          setState(() {});
                        },
                        icon: Icon(
                          loginController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      fillColor: Colors.green.shade100,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.key,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.teal),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()));
                          },
                          child: const Text('Forgot Password'))
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                MyButton(
                  onTap: () {
                    
                    loginController.submitForm();
                  },
                  buttonText: 'Sign In',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const Text('Or Continue with'),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Column(
                  children: [
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        loginController.signInWithGoogle();
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005),
                    SignInButton(
                      Buttons.GitHub,
                      onPressed: () {
                        loginController.signInWithGitHub();
                      },
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not A Member?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.teal),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: const Text(
                          'Register Here',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
