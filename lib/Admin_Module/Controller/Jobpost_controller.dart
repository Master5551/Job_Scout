import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController work_type = TextEditingController();

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
      work_type.text = box.read('work_type') ?? '';
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
    box.write('work_type', work_type.text);

    dataSubmitted = true;

    // Firebase Firestore logic to save form data
    saveFormDataToFirestore(companyNameController.text);
 
  }
}

void saveFormDataToFirestore(String companyName) {
  // Create a map of form data
  Map<String, dynamic> formData = {
    'companyName': companyNameController.text,
    'companyType': companyTypeController.text,
    'lastApplicationDate': lastApplicationDateController.text,
    'jobProfile': jobProfileController.text,
    'package': packageController.text,
    'workLocation': workLocationController.text,
    'jobDescription': jobDescriptionController.text,
    'skillsRequired': skillsRequiredController.text,
    'qualifications': qualificationsController.text,
    'work_type':work_type.text,
    'current_time':DateTime.now(),

  };

   
  // Get a reference to the Firestore collection named "Company"
  CollectionReference companyCollection =
      FirebaseFirestore.instance.collection('Company');

  // Query the "Company" collection to find the document with the matching company name
  companyCollection
      .where('Name', isEqualTo: companyName)
      .get()
      .then((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      // The document with the matching company name exists
      // Get a reference to that document
      DocumentReference companyDocRef = querySnapshot.docs[0].reference;

      // Get a reference to the "jobApplications" subcollection of the specified company document
      CollectionReference jobApplications =
          companyDocRef.collection('Jobpost');

      // Add the form data to the "jobApplications" subcollection
      jobApplications.add(formData).then((value) {
        // Form data added successfully
        // You can add further actions here if needed
        print('Form data added to Firestore successfully');
      }).catchError((error) {
        // Handle errors if any
        print('Error adding form data to Firestore: $error');
      });
    } else {
      // No document with the specified company name was found
      print('Company with name "$companyName" not found in Firestore.');
    }
  });
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
 
}