import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Controller/register_controller.dart';

import 'package:job_scout/components/my_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.002,
              ),
              Text(
                'Welcome to Job Scout App',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: registerController.emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
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
                  controller: registerController.passwordController,
                  obscureText: !registerController.isPasswordVisible.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Your password here",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        registerController.togglePasswordVisibility();
                        setState(() {});
                      },
                      icon: Obx(() => Icon(
                            registerController.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          )),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: registerController.confirmpasswordController,
                  obscureText:
                      !registerController.isPasswordconfirmVisible.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter confirm password';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Your confirm password here",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        registerController.toggleconfirmPasswordVisibility();
                        setState(() {});
                      },
                      icon: Obx(() => Icon(
                            registerController.isPasswordconfirmVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          )),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    fillColor: Colors.green.shade100,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              MyButton(
                onTap: () {
                  registerController.registerWithEmailAndPassword();
                  
                  setState(() {});
                },
                buttonText: 'Sign Up',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have an Account?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.teal),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Login Here'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
