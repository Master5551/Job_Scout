// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:job_scout/User_Module/models/user_data.dart';
// import 'package:job_scout/User_Module/services/user_repository.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserListScreen extends StatelessWidget {
//   final UserRepository userRepository = UserRepository();
//   final User? currentUser = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<UserModel>>(
//         future: userRepository.getUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             List<UserModel> users = snapshot.data ?? [];

//             // Find the details of the current user
//             UserModel currentUser = users.firstWhere(
//               (user) => user.userId == currentUser,
//               orElse: () => UserModel(
//                 userId: "",
//                 firstName: "",
//                 email: "",
//                 lastName: '',
//                 mobileNumber: '',
//                 profession: '',
//                 college: '',
//                 degree: '',
//                 imageUrl: '',
//                 url: '',
//               ),
//             );

//             return SafeArea(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   imageProfile(),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.03,
//                   ),
//                   Text(
//                     '${currentUser.firstName} ${currentUser.lastName}',
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.teal,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.03,
//                   ),
//                   Text(
//                     '${currentUser.profession}',
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.teal,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.03,
//                   ),
//                   Text(
//                     'Count : 30',
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.teal,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.03,
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.01,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text("Edit Profile"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.teal,
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text("Submit Resume"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.teal,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 5,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "Skills",
//                             style: TextStyle(
//                                 fontSize: 30,
//                                 color: Colors.teal,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.6,
//                           ),
//                           IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.add),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       Container(
//                         height: 100,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.vertical,
//                           child: Wrap(
//                             spacing: 20.0, // Horizontal spacing
//                             runSpacing: 20.0, // Vertical spacing
//                             children: [
//                               for (int index = 0; index < 5 * 4; index++)
//                                 Container(
//                                   width: (MediaQuery.of(context).size.width -
//                                           5 * 20.0) /
//                                       4,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.teal),
//                                     borderRadius: BorderRadius.circular(8.0),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "Skill ${index + 1}",
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         color: Colors.teal,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.03,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 5,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     "About",
//                     style: TextStyle(
//                         fontSize: 30,
//                         color: Colors.teal,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '${currentUser.college}',
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.teal,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget imageProfile() {
//     return Stack(
//       children: <Widget>[
//         CircleAvatar(
//           radius: 80.0,
//           backgroundColor:
//               Colors.green.shade100, // Set the default background color
//           // backgroundImage: imageFile == null
//           //     ? Image.asset("assets/images/profile.png")
//           //     : FileImage(File(imageFile!.path)),
//         ),
//         Positioned(
//           bottom: 20.0,
//           right: 20.0,
//           child: InkWell(
//             onTap: () {
//               showModalBottomSheet(
//                 context: Get.context!,
//                 builder: ((builder) => bottomSheet()),
//               );
//             },
//             child: Icon(
//               Icons.camera_alt,
//               color: Colors.teal[200],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget bottomSheet() {
//     return Container(
//       height: 100.0,
//       width: MediaQuery.of(Get.context!).size.width,
//       margin: const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 20,
//       ),
//       child: Column(children: <Widget>[
//         const Text(
//           "Choose Profile photo",
//           style: TextStyle(
//             fontSize: 20.0,
//           ),
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextButton.icon(
//               icon: const Icon(Icons.camera),
//               onPressed: () {
//                 takePhoto(ImageSource.camera);
//               },
//               label: const Text("Camera"),
//             ),
//             TextButton.icon(
//               icon: const Icon(Icons.image),
//               onPressed: () {
//                 takePhoto(ImageSource.gallery);
//               },
//               label: const Text("Gallery"),
//             ),
//           ],
//         )
//       ]),
//     );
//   }

//   void takePhoto(ImageSource source) async {}
// }

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
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
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
                    title: userData['imageUrl'] != null
                        ? Image.network(
                            userData['imageUrl'],
                            width: 200,
                            height: 200,
                          )
                        : Text('No image available'),
                  ),

                  // Other ListTile widgets for different fields
                  Text(userData['name']),
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
                      child: Text('View Your Resume'))
                ],
              );
            } else {
              return Center(child: Text('No user data found.'));
            }
          }
        },
      ),
    );
  }
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
