// ignore_for_file: prefer_const_constructors

import 'package:attendenceapp/admin/mainadmin.dart';
import 'package:attendenceapp/auth/reset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:attendenceapp/screens/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

var uid;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mycontrolle = TextEditingController();
  TextEditingController mypass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool flag = true;
  String emails = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: mycontrolle.text,
        password: mypass.text,
      );

      final User? user = userCredential.user;

      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', mycontrolle.text);
        prefs.setString('password', mypass.text);
        uid = user.uid;
        if (mycontrolle.text == 'ahmadsafdar@gmail.com') {
          Fluttertoast.showToast(
            msg: "Login Successful! As Admin",
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          Fluttertoast.showToast(
            msg: "Login Successful!",
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        }
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromARGB(255, 244, 67, 54),
          content: Text('Enter the correct Email or Password!'),
          duration: Duration(seconds: 2),
        ),
      );
      print('Error signing in: $e');
      // Handle sign-in errors here
    }
  }

  bool isLoading = false;
  Future<void> _handlePressed() async {
    setState(() {
      isLoading = true;
    });
    signInWithEmailAndPassword();
    // Simulate a network request or any async task
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 140, 73, 215),
          title: Center(
              child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Image.asset(
                    "assets/sp.png",
                    height: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: mycontrolle,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 174, 128, 225)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the rounded corner radius here
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 174, 128, 225),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 174, 128, 225),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 174, 128, 225),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) => mycontrolle.text = value ?? '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: mypass,
                    obscureText: flag,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 174, 128, 225)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the rounded corner radius here
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 174, 128, 225),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 174, 128, 225),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        color: Color.fromARGB(255, 174, 128, 225),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              flag = !flag;
                            });
                          },
                          icon: Icon(
                            !flag ? Icons.visibility : Icons.visibility_off,
                            color: !flag
                                ? Color.fromARGB(255, 174, 128, 225)
                                : Colors.black,
                          )),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) => mypass.text = value ?? '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 210),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ));
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Color.fromARGB(255, 140, 73, 215),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 174, 128, 225),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _handlePressed();
                    }
                  },
                  child: isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                      : Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
