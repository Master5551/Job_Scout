import 'package:flutter/material.dart';
import 'package:job_scout/Authentication/login_page.dart';
import 'package:flutter/services.dart';

import 'Authentication/home_page.dart';

void main() {
  runApp(MainApp());

  // Lock the app orientation to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
