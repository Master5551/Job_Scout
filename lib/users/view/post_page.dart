import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Page"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            maxLines: 2,
            decoration: InputDecoration(
              hintText: "Job Title",
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
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            maxLines: 6,
            decoration: InputDecoration(
              hintText: "Job Description",
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
                Icons.badge,
                color: Colors.green,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Post')),
            ],
          ),
        ],
      ),
    );
  }
}
