import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical:20),
        child: ListView(
          children: <Widget>[
            nameTextField(),
            SizedBox(
              height: 20,
            ),
            professionTextField(),
            SizedBox(
              height: 20,
            ),
            dobField(),
            SizedBox(
              height: 20,
            ),
            titleTextField(),
            SizedBox(
               height: 20,
            ),
            aboutTextField(),
            SizedBox(
                height: 20,
            ),
          ],
        ),
      ) ,
    );
  }

  Widget nameTextField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:BorderSide(
            color: Colors.orange,
            width: 2,
          ) ),
        prefixIcon: Icon(Icons.person,
        color: Colors.green[300],
        ),
        labelText: "Name",
        helperText: "Name Can't be empty",
        hintText: "John Doe"
      ),
    );
  }
  Widget professionTextField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:BorderSide(
            color: Colors.orange,
            width: 2,
          ) ),
        prefixIcon: Icon(Icons.person,
        color: Colors.green[300],
        ),
        labelText: "Profession",
        helperText: "Profession Can't be empty",
        hintText: "GoLang Developer"
      ),
    );
  }

Widget dobField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:BorderSide(
            color: Colors.orange,
            width: 2,
          ) ),
        prefixIcon: Icon(Icons.person,
        color: Colors.green[300],
        ),
        labelText: "Date of Birth",
        helperText: "Provide DOB on dd/mm/yyyy",
        hintText: "19/07/2003",
      ),
    );
  }

  Widget titleTextField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:BorderSide(
            color: Colors.orange,
            width: 2,
          ) ),
        prefixIcon: Icon(Icons.person,
        color: Colors.green[300],
        ),
        labelText: "title",
        helperText: "It can't be empty",
        hintText: "Full Stack Developer",
      ),
    );
  }

    Widget aboutTextField(){
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:BorderSide(
            color: Colors.orange,
            width: 2,
          ) ),
        labelText: "About",
        helperText: "Write about yourself",
        hintText: "Full Stack Developer",
      ),
    );
  }
}


