import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Controller/home_controller.dart';
import 'package:job_scout/components/bottom_navigation.dart';
import 'package:job_scout/users/view/search.dart';
import 'package:job_scout/users/Authentication/start_page.dart';
import 'package:job_scout/users/Authentication/register_page.dart';
import 'package:job_scout/users/Authentication/login_page.dart';
import 'package:job_scout/users/view/home_page.dart';
import 'package:job_scout/users/view/profile_page.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    return GetMaterialApp(
      initialBinding: HomeControllerBinding(),
      title: 'Job Scout App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', 
      routes: {
        '/': (context) => user != null ? HomePage() : LoginPage(),
        '/login': (context) => LoginPage(), 
        '/register': (context) => RegisterPage(),
        '/searchpage':(context) => UserSearchScreen(),
        '/homepage':(context) => HomePage(),
        '/profilepage':(context) => ProfilePage(),
        '/bottomnavbar':(context) => BottomNavBar(),
         // Define the RegisterPage route
      },
    );
  }
}

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}