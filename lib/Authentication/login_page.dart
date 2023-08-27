import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_scout/Authentication/home_page.dart';
import 'package:job_scout/Authentication/welcome_screen.dart';
import 'package:job_scout/components/my_button.dart';
import 'package:job_scout/components/my_text_field.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isPasswordVisible = false; // Added state variable

  void signInWithEmailAndPassword() async {
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomePage()), // Replace `NextScreen` with the actual screen you want to navigate to
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No User Found with that email",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM_RIGHT,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "The entered password doesn't match our credentials",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM_RIGHT,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    // Implement your sign-in logic here
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    if (FirebaseAuth.instance.currentUser != null) {
      Homepage();
    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  void Homepage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const WelcomeScreen()), // Replace 'OtherPage' with your page's name
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.002,
              ),
              Text(
                'Welcome to Job Scout App',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              MyTextField(
                suffixIcon: GestureDetector(
                  child: const Icon(Icons.abc),
                ),
                controller: _email,
                hintText: 'Email',
                obscureText: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              MyTextField(
                controller: _password,
                hintText: 'Password',
                obscureText: !_isPasswordVisible, // Use the state variable here
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              MyButton(
                onTap: () {
                  signInWithEmailAndPassword();
                  setState(() {});
                },
                buttonText: 'Sign In',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const Text('Or Continue with'),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Column(
                children: [
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      signInWithGoogle();
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  SignInButton(
                    Buttons.Apple,
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not A Member?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    "Register Now",
                    style: TextStyle(color: Colors.blue, fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
