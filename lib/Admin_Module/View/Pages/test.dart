 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_scout/Admin_Module/View/Pages/fetch_COMpanies.dart';
 import 'package:job_scout/User_Module/Controller/logout_controller.dart';
import 'package:job_scout/User_Module/Controller/stream_controller.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Home/Widgets/icontext.dart';
 import 'package:job_scout/User_Module/View/Master_screen_pages/Profile/Profile_drawer/drawer.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Profile/user_profile_page.dart';
 
 
 
class AllCompanyJobPosts extends StatelessWidget {
  AllCompanyJobPosts({super.key});

   void goToProfilePage() {
    Get.to(UserIDPage());
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search by user name",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.search),
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
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: jobPosts!.length,
              itemBuilder: (context, index) {
                var jobPost = jobPosts[index];
            
                
                return GestureDetector(
                  onTap: (){
                    _showModalBottomSheet(context, jobPost.id, jobPost);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: 270,
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
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  jobPost['companyName'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          jobPost['jobProfile'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
    
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
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Requirement',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
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
                        streamController.searchAndApply(document['companyName'],documentId);
                      //  findthejobpostID(documentId);
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
