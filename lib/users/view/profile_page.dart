import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_scout/Controller/profile_controller.dart';
import 'package:job_scout/users/Authentication/verified_page.dart';
import 'package:job_scout/Controller/send.dart';
import 'package:job_scout/components/my_button.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: <Widget>[
            imageProfile(),
            const SizedBox(height: 20),
            firstnameTextField(),
            const SizedBox(height: 20),
            lastnameTextField(),
            const SizedBox(height: 20),
            mobilenoTextField(),
            const SizedBox(height: 20),
            professionTextField(),
            const SizedBox(height: 20),
            dobField(),
            const SizedBox(height: 20),
            titleTextField(),
            const SizedBox(height: 20),
            aboutTextField(),
            const SizedBox(height: 20),
            Button(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            // backgroundImage: imageFile == null
            //     ? Image.asset("assets/images/profile.png")
            //     : FileImage(File(imageFile!.path)),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: Get.context!,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal[200],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(Get.context!).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(children: <Widget>[
        const Text(
          "Choose Profile photo",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ],
        )
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    // final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    // setState(() {
    //   // imageFile = pickedFile;
    // });
  }

  Widget firstnameTextField() {
    return TextFormField(
      controller: profileController.firstNameController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "First Name",
        helperText: "Name Can't be empty",
        hintText: "John Doe",
      ),
    );
  }

  Widget lastnameTextField() {
    return TextFormField(
      controller: profileController.lastNameController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Last Name",
        helperText: "Name Can't be empty",
        hintText: "John Doe",
      ),
    );
  }

  Widget mobilenoTextField() {
    return TextFormField(
      controller: profileController.mobileNoController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Mobile Number",
        helperText: "Name Can't be empty",
        hintText: "John Doe",
      ),
    );
  }

  Widget professionTextField() {
    return TextFormField(
      controller: profileController.professionController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Profession",
        helperText: "Profession Can't be empty",
        hintText: "GoLang Developer",
      ),
    );
  }

  Widget dobField() {
    return TextFormField(
      controller: profileController.dobController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Date of Birth",
        helperText: "Provide DOB on dd/mm/yyyy",
        hintText: "19/07/2003",
      ),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      controller: profileController.titleController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Title",
        helperText: "It can't be empty",
        hintText: "Full Stack Developer",
      ),
    );
  }

  Widget aboutTextField() {
    return TextFormField(
      controller: profileController.aboutController,
      maxLines: 4,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        labelText: "About",
        helperText: "Write about yourself",
        hintText: "Full Stack Developer",
      ),
    );
  }

  Widget Button() {
    return MyButton(
      onTap: () async {
        try {
          // Create an instance of DataSender and call sendUserDataAndNavigate
          DataSender dataSender = DataSender();
          await dataSender.sendUserDataAndNavigate(
            Get.context!,
            profileController.firstNameController.text,
            profileController.lastNameController.text,
            profileController.mobileNoController.text,
            profileController.professionController.text,
            profileController.dobController.text,
            profileController.titleController.text,
            profileController.aboutController.text,
          );
        } catch (e) {
          print('Error: $e');
        }
      },
      buttonText: "Submit",
    );
  }
}