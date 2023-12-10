import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Admin_Module/Controller/companyjobpostscontroller.dart';
import 'package:job_scout/Admin_Module/View/Pages/appliedusers.dart';
import 'package:job_scout/Admin_Module/View/Pages/post_job.dart';
import 'package:job_scout/User_Module/components/my_list_title.dart';

class CompanyJobPostsView extends StatelessWidget {
  final String companyId;
  final CompanyJobPostsController _controller =
      Get.put(CompanyJobPostsController());

  CompanyJobPostsView({required this.companyId});

  @override
  Widget build(BuildContext context) {
    _controller.getJobPosts(companyId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Posts'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: () {
              _controller.logoutAndRedirectToLogin();
            },
            icon: const Icon(Icons.logout),
          )
        ],
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
            onTap: () => Navigator.pop(context),
          ),
          MyListTitle(
            icon: Icons.person,
            text: 'Job Post',
            onTap: () => Get.to(JobPosting()),
          ),
          MyListTitle(
            icon: Icons.logout,
            text: 'L O G O U T',
            onTap: () => (),
          ),
        ]),
      ),
      body: Obx(() {
        if (_controller.jobPosts.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount:
                _controller.jobPosts.length + 1, // Add 1 for the static text
            itemBuilder: (context, index) {
              if (index == _controller.jobPosts.length) {
                // This is the last item, add your static text here
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Try the premium to Seemlessly schedule google meet while using the application ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.orange, // Customize the color if needed
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                // This is a regular job post item
                Map<String, dynamic> jobPostData =
                    _controller.jobPosts[index].data() as Map<String, dynamic>;
                String jobPostId = _controller.jobPosts[index].id;

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(
                      jobPostData['jobProfile'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Package: ${jobPostData['package']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.info,
                      color: Colors.orange,
                    ),
                    onTap: () {
                      _controller.navigateToAppliedUsersView(
                          jobPostId, companyId);
                    },
                  ),
                );
              }
            },
          );
        }
      }),
    );
  }
}
