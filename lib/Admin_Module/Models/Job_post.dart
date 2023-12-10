import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  String companyName;
  String companyType;
  DateTime lastApplicationDate;
  String jobProfile;
  String package;
  String workLocation;
  String jobDescription;
  String skillsRequired;
  String qualifications;
  DateTime postedate;
  String work_type;
  JobModel({
    required this.companyName,
    required this.companyType,
    required this.lastApplicationDate,
    required this.jobProfile,
    required this.workLocation,
    required this.package,
    required this.postedate,
    required this.jobDescription,
    required this.skillsRequired,
    required this.qualifications,
    required this.work_type,
  });

  // Factory method to create a JobModel instance from a Firestore document
  factory JobModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Convert Timestamp to DateTime
    Timestamp timestamp = data['lastApplicationDate'];
    DateTime lastApplicationDate = timestamp.toDate();
    DateTime posteddate= DateTime.now();
    return JobModel(
      companyName: data['companyName'],
      companyType: data['companyType'],
      lastApplicationDate: lastApplicationDate,
      jobProfile: data['jobProfile'],
      package: data['package'],
      workLocation: data['workLocation'],
      jobDescription: data['jobDescription'],
      skillsRequired: data['skillsRequired'],
      qualifications: data['qualifications'],
      postedate: data['posteddate'],
      work_type: data['work_type'],

    );
  }
}
