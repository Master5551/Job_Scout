import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_scout/User_Module/Controller/company_controller.dart';
import 'package:job_scout/User_Module/Controller/logout_controller.dart';
import 'package:job_scout/User_Module/Controller/stream_controller.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Home/Widgets/icontext.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Profile/Profile_drawer/drawer.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Profile/user_profile_page.dart';
import 'package:job_scout/User_Module/models/user_data.dart';

class AllCompanyJobPosts extends StatelessWidget {
  AllCompanyJobPosts({super.key});

  void goToProfilePage() {
    Get.to(UserIDPage());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ProfileDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: goToProfilePage,
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/searchpage');
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white),
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
                  color: Colors.white,
                  onPressed: () {
                    AuthController().logoutAndRedirectToLogin();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Company').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var companies = snapshot.data!.docs;
          return ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) {
              var company = companies[index];
              String companyId = company.id;

              return CompanyJobPosts(companyId: companyId);
            },
          );
        },
      ),
    );
  }
}

class CompanyJobPosts extends StatelessWidget {
  final String companyId;
  final StreamController streamController = Get.put(StreamController());
  final AuthController authController = Get.put(AuthController());
  final CompanyController companyController = Get.put(CompanyController());
  CompanyJobPosts({required this.companyId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Company')
          .doc(companyId)
          .collection('Jobpost')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var jobPosts = snapshot.data?.docs;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: jobPosts!.map((jobPost) {
              return GestureDetector(
                onTap: () {
                  _showModalBottomSheet(context, jobPost.id, jobPost);
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  width: 350,
                  padding: const EdgeInsets.all(20),
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
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset("assets/images/google.png"),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                jobPost['companyName'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                jobPost['companyType'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.badge,
                                size: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                jobPost['jobProfile'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                jobPost['workLocation'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                jobPost['work_type'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
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

  void storeAppliedCompanyId(String companyId) {
    companyController.addAppliedCompanyId(companyId, currentUser.toString());
  }

  void _showModalBottomSheet(BuildContext context, String documentId,
      DocumentSnapshot<Map<String, dynamic>> document) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // Customize your bottom sheet content here
        return Container(
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
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
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Image.asset("assets/images/google.png"),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          document['companyName'],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  document['jobProfile'],
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconwithText(
                      Icons.location_on_outlined,
                      document['workLocation'],
                      textColor: Colors.black,
                    ),
                    IconwithText(
                      Icons.access_time,
                      document['work_type'],
                      textColor: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Requirement :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(width: 10),
                    Text(
                      document['skillsRequired'],
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Qualification :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(width: 10),
                    Text(
                      document['qualifications'],
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
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
                      streamController.searchAndApply(
                          document['companyName'], documentId);
                      (documentId);
                      showPositivePopup(context);
                      storeAppliedCompanyId(documentId);
                    },
                    child: const Text("Apply Now"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
