import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_scout/User_Module/Controller/profile_controller.dart';
import 'package:job_scout/User_Module/components/my_button.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.teal,
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
            emailTextField(),
            const SizedBox(height: 20),
            mobilenoTextField(),
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
          backgroundColor: Colors.green.shade100, // Set the default background color
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
        hintText: "Enter Your First Name",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.green.shade100,
        filled: true,
        prefixIcon: const Icon(
          Icons.person_2,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget lastnameTextField() {
    return TextFormField(
      controller: profileController.lastNameController,
      decoration: InputDecoration(
        hintText: "Enter Your Last Name",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.green.shade100,
        filled: true,
        prefixIcon: const Icon(
          Icons.person_2,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      controller: profileController.mobileNoController,
      decoration: InputDecoration(
        hintText: "Please enter email",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.green.shade100,
        filled: true,
        prefixIcon: const Icon(
          Icons.mail,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget mobilenoTextField() {
    return TextFormField(
      controller: profileController.professionController,
      decoration: InputDecoration(
        hintText: "Please enter email",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.green.shade100,
        filled: true,
        prefixIcon: const Icon(
          Icons.phone,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget dobField() {
    return TextFormField(
      controller: profileController.dobController,
      decoration: InputDecoration(
        hintText: "Enter Your Date Of Birth",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.green.shade100,
        filled: true,
        prefixIcon: const Icon(
          Icons.date_range,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      controller: profileController.titleController,
      decoration: InputDecoration(
        hintText: "Enter Your Profession",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.green.shade100,
        filled: true,
        prefixIcon: const Icon(
          Icons.book,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget aboutTextField() {
    return TextFormField(
      controller: profileController.aboutController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Tell Us about Yourself",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.green.shade100,
        filled: true,
        prefixIcon: const Icon(
          Icons.account_box_outlined,
          color: Colors.green,
        ),
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
