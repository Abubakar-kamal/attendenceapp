// ignore_for_file: prefer_const_constructors

import 'package:attendenceapp/auth/reset.dart';
import 'package:attendenceapp/auth/login.dart';
import 'package:attendenceapp/screens/bottomnav/about.dart';
import 'package:attendenceapp/screens/bottomnav/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // logout button fn
  void _onLogoutTapped() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _auth.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                prefs.remove('password');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
          automaticallyImplyLeading: true,
          title: Text('Settings'),
          backgroundColor: Color.fromARGB(255, 140, 73, 215),
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _onLogoutTapped();
              },
            ),
          ],
        ),
      ),
    );
  }
}
