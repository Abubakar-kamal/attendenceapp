import 'package:attendenceapp/admin/mainadmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:attendenceapp/auth/login.dart';
import 'package:attendenceapp/screens/mainpage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  // ignore: annotate_overrides
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(
        Duration(seconds: 3)); // Simulate a delay for the splash screen

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if (email != null && password != null) {
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final User? user = userCredential.user;

        if (user != null) {
          uid = user.uid;
          if (email == 'ahmadsafdar@gmail.com') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            Fluttertoast.showToast(
              msg: "Login Successful! as Admin",
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
            Fluttertoast.showToast(
              msg: "Login Successful!",
            );
          }
          return;
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Enter the correct Email or Password!",
        );
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(
      milliseconds: 1000,
    ));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SizedBox(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Image(
                image: AssetImage(
                  "assets/sp.png",
                  //
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
