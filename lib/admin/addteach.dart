import 'package:attendenceapp/model/random.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _course = TextEditingController();

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );

        await _firestore
            .collection('teachers')
            .doc(userCredential.user!.uid)
            .set({
          'teacherId': CodeGenerator.generateCode(),
          'name': _name.text,
          'email': _email.text,
          'course': _course.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully')),
        );
        // setState(() {
        //   _name.clear();
        //   _email.clear();
        //   _password.clear();
        //   _course.clear();
        // });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create account: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 450,
              width: 380,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/sp.png"),
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(
                          0.7), // Adjust opacity to make the image lighter
                      BlendMode.lighten,
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Teacher Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the rounded corner radius here
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 140, 73, 215),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 73, 215),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 73, 215),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: _name,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Teacher Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the rounded corner radius here
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 140, 73, 215),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 73, 215),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 73, 215),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    controller: _email,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the rounded corner radius here
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        color: Color.fromARGB(255, 140, 73, 215),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 73, 215),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 73, 215),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: _password,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Course',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the rounded corner radius here
                      ),
                      prefixIcon: Icon(
                        Icons.book,
                        color: Color.fromARGB(255, 140, 73, 215),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 73, 215),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 73, 215),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your course';
                      }
                      return null;
                    },
                    controller: _course,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _signUp,
                    child: Text('Create'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
