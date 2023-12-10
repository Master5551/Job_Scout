import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_scout/User_Module/Controller/company_controller.dart';
import 'package:job_scout/User_Module/Controller/logout_controller.dart';
import 'package:job_scout/User_Module/Controller/stream_controller.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Home/Widgets/icontext.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Profile/Profile_drawer/drawer.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Profile/user_profile_page.dart';

class StreamExample extends StatefulWidget {
  @override
  _StreamExampleState createState() => _StreamExampleState();
}

class _StreamExampleState extends State<StreamExample> {
  List<String> appliedCompanyIds = [];
  final StreamController streamController = Get.put(StreamController());
  final AuthController authController = Get.put(AuthController());
  final StreamController controller = Get.put(StreamController());
  final CompanyController companyController = Get.put(CompanyController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  bool isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  
  void _initializeData() {
    CollectionReference<Map<String, dynamic>> companyCollectionRef =
        FirebaseFirestore.instance.collection('Company');

    companyCollectionRef.snapshots().listen(
      (QuerySnapshot<Map<String, dynamic>> snapshot) {
        streamController.clearDocuments();

        for (var companyDoc in snapshot.docs) {
          CollectionReference<Map<String, dynamic>> jobpostCollectionRef =
              companyDoc.reference.collection('Jobpost');

          jobpostCollectionRef.snapshots().listen(
            (QuerySnapshot<Map<String, dynamic>> jobpostSnapshot) {
              streamController.updateDocuments(jobpostSnapshot.docs);

              print(
                  'Jobpost subcollection data: ${jobpostSnapshot.docs.map((doc) => doc.data())}');
            },
          );
        }
      },
    );
  }

  void showPositivePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your application has been successfully submitted.'),
                SizedBox(height: 20),
                // Image.asset(
                //   'assets/success_image.png', // Replace this with your image path
                //   height: 100,
                //   width: 100,
                // ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onPressedFunction(
  DocumentSnapshot<Map<String, dynamic>> document,
  String documentId,
) {
  if (isButtonEnabled) {
    setState(() {
      isButtonEnabled = false;
    });

    final companyData = {
      'companyName': document['companyName'],
      'companyType': document['companyType'],
      // Add other fields similarly
    };

    companyData['current_time'] = Timestamp.now(); // Example timestamp creation

    // companyController.addAppliedCompany(
    //   id: documentId,
    //   userId: currentUser.toString(),
    //   companyData: companyData,
    // );

    showPositivePopup(context);
  }
}


  void _showModalBottomSheet(BuildContext context, String documentId,
      DocumentSnapshot<Map<String, dynamic>> document) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // Customize your bottom sheet content here
        return Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          height: 550,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 60,
                  color: Colors.grey.withOpacity(0.3),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Image.asset("assets/images/google.png"),
                        ),
                        SizedBox(width: 10),
                        Text(
                          document['companyName'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  document['jobProfile'],
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconwithText(
                      Icons.location_on_outlined,
                      document['workLocation'],
                      textColor: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Requirement',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  height: 45,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      onPressedFunction(document, documentId);
                    },
                    child: Text("Apply Now"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void goToProfilePage() {
    Get.to(UserIDPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ProfileDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: goToProfilePage,
      ),
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/searchpage');
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.teal),
                        color: Colors.green.shade100,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search by user name",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.teal,
                            onPressed: () {
                              Get.toNamed('/searchpage');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(Icons.logout),
                  color: Colors.teal,
                  onPressed: () {
                    AuthController().logoutAndRedirectToLogin();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (streamController.documents.isNotEmpty) {
          return ListView.builder(
            itemCount: streamController.documents.length,
            itemBuilder: (context, index) {
              var document = streamController.documents[index];
              return GestureDetector(
                onTap: () {
                  _showModalBottomSheet(context, document.id, document);
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: 270,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset("assets/images/google.png"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                document['companyName'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                document['companyType'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            document['jobProfile'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            document['workLocation'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            document['work_type'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      }),
    );
  }
}