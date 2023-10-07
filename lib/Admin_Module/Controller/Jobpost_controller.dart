import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JobController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final box = GetStorage(); // Get Storage instance
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyTypeController = TextEditingController();
  TextEditingController lastApplicationDateController = TextEditingController();
  TextEditingController jobProfileController = TextEditingController();
  TextEditingController packageController = TextEditingController();
  TextEditingController workLocationController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController skillsRequiredController = TextEditingController();
  TextEditingController qualificationsController = TextEditingController();

  bool dataSubmitted = false; // Flag to track if data is submitted

  // Initialize controller and load saved data
  @override
  void onInit() {
    super.onInit();
    // Load saved data from Get Storage if data is not submitted
    if (!dataSubmitted) {
      companyNameController.text = box.read('companyName') ?? '';
      companyTypeController.text = box.read('companyType') ?? '';
      lastApplicationDateController.text = box.read('lastApplicationDate') ?? '';
      jobProfileController.text = box.read('jobProfile') ?? '';
      packageController.text = box.read('package') ?? '';
      workLocationController.text = box.read('workLocation') ?? '';
      jobDescriptionController.text = box.read('jobDescription') ?? '';
      skillsRequiredController.text = box.read('skillsRequired') ?? '';
      qualificationsController.text = box.read('qualifications') ?? '';
    }
  }

  // Submit the form
  void submitForm() {
  if (formKey.currentState!.validate()) {
    // Save form data to Get Storage
    box.write('companyName', companyNameController.text);
    box.write('companyType', companyTypeController.text);
    box.write('lastApplicationDate', lastApplicationDateController.text);
    box.write('jobProfile', jobProfileController.text);
    box.write('package', packageController.text);
    box.write('workLocation', workLocationController.text);
    box.write('jobDescription', jobDescriptionController.text);
    box.write('skillsRequired', skillsRequiredController.text);
    box.write('qualifications', qualificationsController.text);

    // Clear form data
    companyNameController.clear();
    companyTypeController.clear();
    lastApplicationDateController.clear();
    jobProfileController.clear();
    packageController.clear();
    workLocationController.clear();
    jobDescriptionController.clear();
    skillsRequiredController.clear();
    qualificationsController.clear();

    // Update the dataSubmitted flag to true
    dataSubmitted = true;

    // Continue with form submission logic
    // ...
  }
}

  
}
Future<DateTime?> _selectDate(BuildContext context, DateTime initialDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );
  return picked;
}

Future<TimeOfDay?> _selectTime(BuildContext context, TimeOfDay initialTime) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
  return picked;
}