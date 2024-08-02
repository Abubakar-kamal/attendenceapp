// ignore_for_file: prefer_const_constructors

import 'package:attendenceapp/screens/cal.dart';
import 'package:attendenceapp/screens/history2.dart';
import 'package:attendenceapp/screens/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attendenceapp/model/firestoremodel.dart'; // Import your model
// Import your service class

class Result extends StatefulWidget {
  final String? collection;
  final String? subcollection; // The collection name passed from MainPage

  Result({Key? key, this.collection, this.subcollection})
      : super(key: key);
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final StudentService _studentService = StudentService();
  List<Student> students = [];
  String roll = '';
  int inc = 0;
  int inc1 = 0;
  int inc2 = 0;
  double per = 0;
  double abs = 0;
  String? _documentId;
  bool _isLoading = true;
  bool present = false;
  bool quiz = false;
  bool assignment = false;
  bool isSaving = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    _fetchStudents();
    _fetchDocumentId();
  }

  Future<void> _fetchDocumentId() async {
    String? documentId = await _studentService
        .getFirstDocumentId(widget.collection!); // Example collection name
    setState(() {
      _documentId = documentId;
      _isLoading = false;
    });
  }

  Future<void> _fetchStudents() async {
    List<Student> fetchedStudents =
        await _studentService.fetchStudentsFromSubCollection(
            widget.collection!, widget.subcollection!);

    setState(() {
      students = fetchedStudents;
      // Sort students by roll number
      students.sort((a, b) => a.rollno.compareTo(b.rollno));
      _isLoading = false;
    });
  }

  Future<void> incrementTotal(String collectionName, String documentId,
      String subCollectionName, String rollNo) async {
    try {
      // Fetch the document with the given roll number in the subcollection.
      QuerySnapshot snapshot = await _firestore
          .collection(collectionName)
          .doc(documentId)
          .collection(subCollectionName)
          .where('rollno', isEqualTo: rollNo)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Assuming roll numbers are unique, there should be only one document.
        DocumentSnapshot studentDoc = snapshot.docs.first;
        // Increment the totalPresent field.
        await _firestore
            .collection(collectionName)
            .doc(documentId)
            .collection(subCollectionName)
            .doc(studentDoc.id)
            .update({
          'totalpresent': FieldValue.increment(1),
        });
        print("Successfully incremented totalPresent for roll number $rollNo");
      } else {
        print("No student found with roll number $rollNo");
      }
    } catch (e) {
      print('Error incrementing totalPresent: $e');
    }
  }

  Future<void> incrementTotalquiz(String collectionName, String documentId,
      String subCollectionName, String rollNo) async {
    try {
      // Fetch the document with the given roll number in the subcollection.
      QuerySnapshot snapshot = await _firestore
          .collection(collectionName)
          .doc(documentId)
          .collection(subCollectionName)
          .where('rollno', isEqualTo: rollNo)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Assuming roll numbers are unique, there should be only one document.
        DocumentSnapshot studentDoc = snapshot.docs.first;
        // Increment the totalPresent field.
        await _firestore
            .collection(collectionName)
            .doc(documentId)
            .collection(subCollectionName)
            .doc(studentDoc.id)
            .update({
          'totalquiz': FieldValue.increment(1),
        });
        print("Successfully incremented totalPresent for roll number $rollNo");
      } else {
        print("No student found with roll number $rollNo");
      }
    } catch (e) {
      print('Error incrementing totalPresent: $e');
    }
  }

  Future<void> incrementTotalassign(String collectionName, String documentId,
      String subCollectionName, String rollNo) async {
    try {
      // Fetch the document with the given roll number in the subcollection.
      QuerySnapshot snapshot = await _firestore
          .collection(collectionName)
          .doc(documentId)
          .collection(subCollectionName)
          .where('rollno', isEqualTo: rollNo)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Assuming roll numbers are unique, there should be only one document.
        DocumentSnapshot studentDoc = snapshot.docs.first;
        // Increment the totalPresent field.
        await _firestore
            .collection(collectionName)
            .doc(documentId)
            .collection(subCollectionName)
            .doc(studentDoc.id)
            .update({
          'totalassign': FieldValue.increment(1),
        });
        print("Successfully incremented totalPresent for roll number $rollNo");
      } else {
        print("No student found with roll number $rollNo");
      }
    } catch (e) {
      print('Error incrementing totalPresent: $e');
    }
  }

  Future<void> updatePresent(String collectionName, String documentId,
      String subCollectionName, String rollNo) async {
    try {
      // Fetch the document with the given roll number in the subcollection.
      QuerySnapshot snapshot = await _firestore
          .collection(collectionName)
          .doc(documentId)
          .collection(subCollectionName)
          .where('rollno', isEqualTo: rollNo)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Assuming roll numbers are unique, there should be only one document.
        DocumentSnapshot studentDoc = snapshot.docs.first;
        // Increment the totalPresent field.
        await _firestore
            .collection(collectionName)
            .doc(documentId)
            .collection(subCollectionName)
            .doc(studentDoc.id)
            .update({
          'ispresent': true,
        });
        print("Successfully incremented totalPresent for roll number $rollNo");
      } else {
        print("No student found with roll number $rollNo");
      }
    } catch (e) {
      print('Error incrementing totalPresent: $e');
    }
  }

  Future<void> updatePresent1(String collectionName, String documentId,
      String subCollectionName, String rollNo) async {
    try {
      // Fetch the document with the given roll number in the subcollection.
      QuerySnapshot snapshot = await _firestore
          .collection(collectionName)
          .doc(documentId)
          .collection(subCollectionName)
          .where('rollno', isEqualTo: rollNo)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Assuming roll numbers are unique, there should be only one document.
        DocumentSnapshot studentDoc = snapshot.docs.first;
        // Increment the totalPresent field.
        await _firestore
            .collection(collectionName)
            .doc(documentId)
            .collection(subCollectionName)
            .doc(studentDoc.id)
            .update({
          'ispresent': false,
        });
        print("Successfully incremented totalPresent for roll number $rollNo");
      } else {
        print("No student found with roll number $rollNo");
      }
    } catch (e) {
      print('Error incrementing totalPresent: $e');
    }
  }

  Future<void> updatePresentForAll(String collectionName, String documentId,
      String subCollectionName) async {
    try {
      // Fetch all documents in the subcollection.
      QuerySnapshot snapshot = await _firestore
          .collection(collectionName)
          .doc(documentId)
          .collection(subCollectionName)
          .get();

      // Update each document's 'ispresent' field to false.
      for (var doc in snapshot.docs) {
        await _firestore
            .collection(collectionName)
            .doc(documentId)
            .collection(subCollectionName)
            .doc(doc.id)
            .update({
          'ispresent': false,
        });
      }
      print(
          "Successfully set 'ispresent' to false for all records in $subCollectionName");
    } catch (e) {
      print('Error updating present status: $e');
    }
  }

  Future<void> saveStudents() async {
    setState(() {
      isSaving = true;
    });

    try {
      for (var student in students) {
        await _studentService.createDocumentWithTodayDate(
          widget.collection!,
          widget.subcollection!,
          student.studentname ?? 'No Name',
          student.rollno ?? 'N/A',
          student.address ?? 'N/A',
          student.father ?? 'N/A',
          student.phone ?? 'N/A',
          student.quizt,
          student.assignment,
          student.present,
          student.total,
          student.quizt,
          student.assign,
        );
      }
    } catch (e) {
      print('Error saving students: $e');
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  void _showStudentDetails(Student student) {
    showDialog(
      context: context,
      builder: (context) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Student Details"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(
                    text: 'Name: ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${student.studentname ?? 'N/A'}',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  )),
                  Text("RollNo : ${student.rollno}"),
                  Text("Address : ${student.address}"),
                  Text("Father Name : ${student.father}"),
                  Text("Phone Number : ${student.phone}"),
                  Text("Total Present : ${student.total}/30"),
                  Text("Total Assignment : ${student.quizt}"),
                  Text("Total Quiz : ${student.assign}"),
                  Divider(),
                  Text('Calculate Percentage'),
                  Center(
                      child: Text('$per %',
                          style: TextStyle(color: Colors.black, fontSize: 36))),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        int para = int.parse(student.total.toString());
                        per = para / 30 * 100;
                        abs = 30 - student.total.toDouble();
                      });
                    },
                    child: Text('Calculate'),
                  ),
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showChecklist(Student student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Checklist for ${student.studentname}"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CheckboxListTile(
                    title: Text("Quiz"),
                    value: student.quiz,
                    onChanged: (bool? value) {
                      setState(() {
                        incrementTotalquiz(widget.collection!, _documentId!,
                            widget.subcollection!, student.rollno);
                        print(inc2);
                        student.quiz = value!;
                        quiz = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Assignment"),
                    value: student.assignment,
                    onChanged: (bool? value) {
                      setState(() {
                        incrementTotalassign(widget.collection!, _documentId!,
                            widget.subcollection!, student.rollno);
                        print(inc2);
                        student.assignment = value!;
                        assignment = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 174, 128, 225).withOpacity(45),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Attendance'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => History(
                            collection: widget.collection,
                            subcollection: widget.subcollection,
                          )),
                );
              },
              icon: Icon(Icons.history)),
                IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Result(
                            collection: widget.collection,
                            subcollection: widget.subcollection,
                          )),
                );
              },
              icon: Icon(Icons.history)),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.separated(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            subtitle: GestureDetector(
              onTap: () {
                _fetchStudents();
                _showStudentDetails(students[index]);
              },
              child: Container(
                
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          students[index].rollno,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          students[index].studentname,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                       
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  Text("Total Percentage : ${(students[index].total / 30 * 100).toStringAsFixed(2)}%"),
                
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer),
          onPressed: isSaving
              ? null
              : () async {
                  setState(() {
                    isSaving = true;
                  });
                  await saveStudents().whenComplete(() {
                    updatePresentForAll(
                      widget.collection!,
                      _documentId!,
                      widget.subcollection!,
                    );
                  });
                  setState(() {
                    isSaving = false;
                  });
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainPage()));
                  print(_documentId);
                },
          child: isSaving
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text('Save')),
    );
  }
}
