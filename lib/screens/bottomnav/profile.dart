// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:attendenceapp/auth/login.dart';
import 'package:attendenceapp/model/teachermode.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Teacher? teacher;
  bool isLoading = true;
  String? imagePath;
  @override
  void initState() {
    super.initState();
    _loadTeacher();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
      await _saveImagePath(imagePath!);
    }
  }

  Future<void> _saveImagePath(String path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', path);
  }

  Future<void> _loadImagePath() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      imagePath = prefs.getString('imagePath');
    });
  }

  Future<void> _loadTeacher() async {
    try {
      FirestoreService firestoreService = FirestoreService();
      Teacher fetchedTeacher = await firestoreService.fetchTeacher(uid);
      setState(() {
        teacher = fetchedTeacher;
        isLoading = false;
      });
    } catch (e) {
      print('Failed to fetch teacher: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : teacher == null
                ? Center(child: Text('Failed to load teacher data'))
                : Container(
                    color: Colors.white30,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                maxRadius: 70,
                                backgroundImage: imagePath != null
                                    ? FileImage(File(imagePath!))
                                    : AssetImage("assets/profile.png")
                                        as ImageProvider,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Name: ${teacher!.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 26,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Text("@Bzu")],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Teacher at BZU",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: ListView(
                            children: [
                              Card(
                                margin: const EdgeInsets.only(
                                  left: 35,
                                  right: 35,
                                  bottom: 10,
                                ),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.email,
                                    color: Colors.purple,
                                  ),
                                  title: Text(
                                    "${teacher!.email}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Card(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                margin: const EdgeInsets.only(
                                  left: 35,
                                  right: 35,
                                  bottom: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.subject,
                                    color: Colors.purple,
                                  ),
                                  title: Text(
                                    ' ${teacher!.subject}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Card(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                margin: const EdgeInsets.only(
                                  left: 35,
                                  right: 35,
                                  bottom: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.perm_identity,
                                    color: Colors.purple,
                                  ),
                                  title: Text(
                                    ' ${teacher!.teacher}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
