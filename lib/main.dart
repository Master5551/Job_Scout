import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_scout/Admin_Module/View/Pages/cards.dart';
import 'package:job_scout/Admin_Module/View/Pages/post_job.dart';
import 'package:job_scout/Admin_Module/View/Pages/status.dart';
import 'package:job_scout/User_Module/Controller/home_controller.dart';
import 'package:job_scout/User_Module/View/Before_master_page/new_user_page_2.dart';
import 'package:job_scout/User_Module/View/Splash_screen/splash_screen.dart';
import 'package:job_scout/User_Module/components/bottom_navigation.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/search.dart';
import 'package:job_scout/User_Module/View/Welcome_page/start_page.dart';
import 'package:job_scout/User_Module/View/Authentication/Register_page/register_page.dart';
import 'package:job_scout/User_Module/View/Authentication/Login_page/login_page.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/Home/home_page.dart';
import 'package:job_scout/User_Module/View/Master_screen_pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init(); // Initialize Get Storage

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: HomeControllerBinding(),
      title: 'Job Scout App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/adminmodule': (context) => UserListPage(),
        '/checkuser': (context) => user != null ? BottomNavBar() : LoginPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/searchpage': (context) => UserSearchScreen(),
        '/homepage': (context) => HomePage(),
        '/profilepage': (context) => BottomNavBar(),
        '/bottomnavbar': (context) => BottomNavBar(),
        '/newuserpage_2': (context) => NewUserPage2(),
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
