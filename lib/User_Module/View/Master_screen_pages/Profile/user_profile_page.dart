import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserIDPage extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>?> fetchCurrentUserData(
      String currentUserId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUserId)
              .get();

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
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: fetchCurrentUserData(currentUser?.uid ?? ''),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final userData = snapshot.data;
              if (userData != null) {
                return ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    ListTile(
                        title: SizedBox(
                      width: 200,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                            width: 2.0, // Adjust border width as needed
                          ),
                        ),
                        child: userData['imageUrl'] != null
                            ? Image.network(
                                userData['imageUrl'],
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: Colors.grey,
                                child: Center(
                                  child: Text(
                                    'No image available',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ),
                    )),
                    _buildTextWidget(
                        context, 'First Name', userData['firstName']),
                    _buildTextWidget(
                        context, 'Last Name', userData['lastName']),
                    _buildTextWidget(context, 'College', userData['college']),
                    _buildTextWidget(
                        context, 'Profession', userData['profession']),
                    _buildTextWidget(context, 'Email', userData['email']),
                    _buildTextWidget(
                        context, 'Mobile Number', userData['mobileNumber']),
                    _buildTextWidget(context, 'About', userData['about']),
                    _buildSkillList(userData['skills']),
                    TextButton(
                      onPressed: () {
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
                      child: Text('View Your Resume'),
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.green)), // Border color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust border radius as needed
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.teal), // Button background color
                        foregroundColor: MaterialStateProperty.all(
                            Colors.white), // Text color
                      ),
                    )
                  ],
                );
              } else {
                return Center(child: Text('No user data found.'));
              }
            }
          },
        ),
      ),
    );
  }
}

Widget _buildTextWidget(BuildContext context, String label, String value) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.green), // Green border
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: EdgeInsets.all(8.0),
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label + ':',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSkillList(dynamic skillsData) {
  if (skillsData != null && skillsData is List<dynamic>) {
    List<String> skills = skillsData.cast<String>();

    if (skills.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for (var skill in skills)
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(skill),
                ),
            ],
          ),
        ],
      );
    }
  }
  return SizedBox.shrink();
}

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  final String name;

  PdfViewerScreen({required this.pdfUrl, required this.name});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PDFDocument? document;

  void initialisePdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initialisePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: document != null
          ? PDFViewer(document: document!)
          : Center(child: Text('Document not available')),
    );
  }
}
