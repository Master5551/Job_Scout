import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_scout/components/my_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late PickedFile? imageFile;
  final ImagePicker imagePicker = ImagePicker();

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
          const CircleAvatar(
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
                  context: context,
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
      width: MediaQuery.of(context).size.width,
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
    setState(() {
      // imageFile = pickedFile;
    });
  }

  Widget firstnameTextField() {
    return TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green[300],
          ),
          labelText: "first name",
          helperText: "Name Can't be empty",
          hintText: "John Doe"),
    );
  }

  Widget lastnameTextField() {
    return TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green[300],
          ),
          labelText: "last name",
          helperText: "Name Can't be empty",
          hintText: "John Doe"),
    );
  }

  Widget mobilenoTextField() {
    return TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green[300],
          ),
          labelText: "Enter Your Mobile Number",
          helperText: "Name Can't be empty",
          hintText: "John Doe"),
    );
  }

  Widget professionTextField() {
    return TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green[300],
          ),
          labelText: "Profession",
          helperText: "Profession Can't be empty",
          hintText: "GoLang Developer"),
    );
  }

  Widget dobField() {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green[300],
        ),
        labelText: "Date of Birth",
        helperText: "Provide DOB on dd/mm/yyyy",
        hintText: "19/07/2003",
      ),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green[300],
        ),
        labelText: "title",
        helperText: "It can't be empty",
        hintText: "Full Stack Developer",
      ),
    );
  }

  Widget aboutTextField() {
    return TextFormField(
      maxLines: 4,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: "About",
        helperText: "Write about yourself",
        hintText: "Full Stack Developer",
      ),
    );
  }

  Widget Button() {
    return MyButton(
      onTap: () {
        setState(() {});
      },
      buttonText: 'Submit',
    );
  }
}
