import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_scout/User_Module/Controller/Auth_Controllers/User_state_controller/user_state_controller.dart';
import 'package:job_scout/User_Module/View/Before_master_page/new_user_page_2.dart';
import 'package:lottie/lottie.dart';

class NewUserPage extends StatelessWidget {
  NewUserPage({Key? key});
  UserStateController userstatecontroller = Get.find<UserStateController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String? userEmail = userstatecontroller.getUserEmail;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
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
                SizedBox(width: 10),
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
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Upload Your Image By Clicking here :-",
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () async {
                          ImagePicker imagepicker = ImagePicker();
                          XFile? file = await imagepicker.pickImage(
                              source: ImageSource.gallery);
                          print('${file?.path}');

                          if (file == null) return;

                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');

                          Reference referenceimageUpload =
                              referenceDirImages.child(uniqueFileName);

                          try {
                            await referenceimageUpload
                                .putFile(File(file!.path));
                            userstatecontroller.imageUrl =
                                await referenceimageUpload.getDownloadURL();
                          } catch (error) {
                            print("djgmad");
                          }
                        },
                        icon: Icon(Icons.upload)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      child: TextFormField(
                        controller: userstatecontroller.firstName,
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
                        controller: userstatecontroller.lastName,
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
                        readOnly:
                            true, // Set readOnly to true to mimic a disabled state
                        onTap: () {
                          // Prevent keyboard from appearing when tapped
                          // You can leave this function empty
                        },
                        controller: userstatecontroller.email,
                        decoration: InputDecoration(
                          hintText: userEmail,
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
                      width: 200, // Set a fixed width or adjust as needed
                      child: TextFormField(
                        maxLength: 10,
                        controller: userstatecontroller.mobileNumber,
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
                    TextButton(
                      onPressed: userstatecontroller.verifyPhoneNumber,
                      child: Text('Verify'),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300, // Set a fixed width or adjust as needed
                      child: TextFormField(
                        controller: userstatecontroller.about,
                        maxLines: 5,
                        maxLength: 2000,
                        decoration: InputDecoration(
                          hintText: "Tell us About Yourself",
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
                    userstatecontroller.performValidations()
                        ? Get.to(NewUserPage2())
                        : Get.to(NewUserPage());
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
      ),
    );
  }
}
