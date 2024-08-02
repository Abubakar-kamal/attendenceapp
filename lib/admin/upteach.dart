import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeacherListPage extends StatefulWidget {
  @override
  _TeacherListPageState createState() => _TeacherListPageState();
}

class _TeacherListPageState extends State<TeacherListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _updateTeacher(
      String id, String name, String email, String course) async {
    try {
      await _firestore.collection('teachers').doc(id).update({
        'name': name,
        'email': email,
        'course': course,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teacher information updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update teacher: $e')),
      );
    }
  }

  void _deleteTeacher(String id, String email) async {
    try {
      // Delete teacher from Firestore
      await _firestore.collection('teachers').doc(id).delete();

      // Find the user in Firebase Authentication by email

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teacher deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete teacher: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(218, 211, 245, 1),
        title: Text('Teachers List'),
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
          StreamBuilder(
            stream: _firestore.collection('teachers').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final teachers = snapshot.data!.docs;

              return ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  final teacher = teachers[index];

                  TextEditingController nameController =
                      TextEditingController(text: teacher['name'] ?? '');
                  TextEditingController emailController =
                      TextEditingController(text: teacher['email'] ?? '');
                  TextEditingController courseController =
                      TextEditingController(text: teacher['course'] ?? '');

                  return ListTile(
                    title: Text(teacher['name'] ?? 'No Name'),
                    subtitle: Text(teacher['email'] ?? 'No Email'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Update Teacher'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: nameController,
                                        decoration:
                                            InputDecoration(labelText: 'Name'),
                                      ),
                                      TextField(
                                        controller: emailController,
                                        decoration:
                                            InputDecoration(labelText: 'Email'),
                                      ),
                                      TextField(
                                        controller: courseController,
                                        decoration: InputDecoration(
                                            labelText: 'Course'),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _updateTeacher(
                                            teacher.id,
                                            nameController.text,
                                            emailController.text,
                                            courseController.text);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Update'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteTeacher(teacher.id, teacher['email']);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
