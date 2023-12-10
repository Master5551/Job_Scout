import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_scout/Admin_Module/Controller/Jobpost_controller.dart';
import 'package:job_scout/Admin_Module/Models/company.dart';
import 'package:job_scout/Admin_Module/View/Pages/companyjobposts.dart';
import 'package:job_scout/User_Module/components/my_list_title.dart'; // Import your JobController class

class JobPosting extends StatelessWidget {
  final JobController jobController = Get.put(JobController());
  TextEditingController jobDescriptionController = TextEditingController();
  Future<DateTime?> _selectDate(
      BuildContext context, DateTime initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    return picked;
  }

  String getcompany() {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser?.uid ?? ''; // Return empty string if currentUser is null
  }

  Future<TimeOfDay?> _selectTime(
      BuildContext context, TimeOfDay initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Posting'),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        backgroundColor: Colors.orange[100],
        child: Column(children: [
          DrawerHeader(
              child: Icon(
            Icons.person,
            color: Colors.white,
            size: 64,
          )),
          MyListTitle(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () => Get.to(CompanyJobPostsView(
              companyId: getcompany(),
            )),
          ),
          MyListTitle(
            icon: Icons.person,
            text: 'Job Post',
            onTap: () => Navigator.pop(context),
          ),
          MyListTitle(
            icon: Icons.logout,
            text: 'L O G O U T',
            onTap: () => (),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<JobController>(
          builder: (controller) {
            return Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: controller.companyNameController,
                    decoration: InputDecoration(
                      hintText: "Company Name",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        Get.snackbar(
                          "Validation Error",
                          "Please fill out the company name field",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return 'Please fill out the company name field';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.companyTypeController,
                    decoration: InputDecoration(
                      hintText: "Type of Company",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.lastApplicationDateController,
                    onTap: () async {
                      final selectedDate =
                          await _selectDate(context, controller.selectedDate);
                      if (selectedDate != null) {
                        final selectedTime =
                            await _selectTime(context, controller.selectedTime);
                        if (selectedTime != null) {
                          final dateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                          controller.selectedDate = dateTime;
                          final formattedDate =
                              DateFormat('yyyy-MM-dd hh:mm a z', 'en_US')
                                  .format(dateTime.toUtc()); // Format as GMT
                          controller.lastApplicationDateController.text =
                              formattedDate;
                        }
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Last Application Date",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.jobProfileController,
                    decoration: InputDecoration(
                      hintText: "Job Profile",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.packageController,
                    decoration: InputDecoration(
                      hintText: "Package",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.work_type,
                    decoration: InputDecoration(
                      hintText: "Work type(eg:full,part time)",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.workLocationController,
                    decoration: InputDecoration(
                      hintText: "Work Location",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: jobDescriptionController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Job Description (Use * for bullets)",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String inputText = jobDescriptionController.text;
                      List<String> lines =
                          inputText.split('\n'); // Split by newlines

                      // Process each line
                      List<String> bulletedLines = lines.map((line) {
                        // Check if the line already starts with a bullet point
                        if (line.trimLeft().startsWith('•')) {
                          return line; // Leave it as is
                        } else {
                          return line.trimLeft().startsWith('*')
                              ? '•' + line.substring(1)
                              : '• $line'; //Add bullet points
                        }
                      }).toList();

                      // Join the modified lines with line breaks
                      String formattedText = bulletedLines.join('\n');

                      // Update the controller with the formatted text
                      jobDescriptionController.text = formattedText;

                      // Call the submitForm method from JobController
                    },
                    child: const Text('Format'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.skillsRequiredController,
                    decoration: InputDecoration(
                      hintText: "Skills Required",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.qualificationsController,
                    decoration: InputDecoration(
                      hintText: "Qualifications",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.submitForm();
                      print("getcompany() = " + getcompany());
                      // Get.to(CompanyJobPostsView(companyId: getcompany()));
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
