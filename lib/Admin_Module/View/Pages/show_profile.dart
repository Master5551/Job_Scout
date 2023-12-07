import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Profile/user_profile_page.dart';

class UserIDPage extends StatelessWidget {
  final String currentUser;

  UserIDPage(this.currentUser);

  Future<Map<String, dynamic>?> fetchCurrentUserData(String currentUserId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(currentUserId).get();

      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        print('Document does not exist.');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('User Profile'),
      ),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: fetchCurrentUserData(currentUser),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final userData = snapshot.data;
              if (userData != null) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.teal,
                            width: 2.0,
                          ),
                        ),
                        child: ClipOval(
                          child: userData['imageUrl'] != null
                              ? Image.network(
                                  userData['imageUrl'],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.grey,
                                  child: const Center(
                                    child: Text(
                                      'No image available',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildIDCardInfoWidget('Name', '${userData['firstName']} ${userData['lastName']}'),
                      _buildIDCardInfoWidget('College', userData['college']),
                      _buildIDCardInfoWidget('Degree', userData['degree']),
                      _buildIDCardInfoWidget('Mobile Number', userData['mobileNumber']),
                      _buildIDCardInfoWidget('Resume URL', userData['url']),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the PDF viewer screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewerScreen(
                                pdfUrl: userData['url'],
                                name: userData['name'],
                              ),
                            ),    
                          );
                        },
                        child: const Text('View Applicants Resume'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('No user data found.'));
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildIDCardInfoWidget(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
