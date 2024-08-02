import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  _StudentFormPageState createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? docId;
  String studentName = '';
  String rollNo = '';
  String address = '';
  String fatherName = '';
  String phone = '';
  bool quiz = false;
  bool assignment = false;
  bool present = false;
  int total = 0;
  String? _selectedItem;
  String? _selectedCollection;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController studentNameController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  List<String> items1 = ["Morning", "Evening"];
  List<String> collections = [
    'Semester1',
    'Semester3',
    'Semester5',
    'Semester7',
  ];

  Future<void> addStudentDirectly(
    String mainCollection,
    String timeOfDay,
    String studentName,
    String rollNo,
    String address,
    String fatherName,
    String phone,
    bool quiz,
    bool assignment,
    bool present,
    int total,
    int total1,
    int total2,
  ) async {
    try {
      CollectionReference studentsRef = _firestore
          .collection(mainCollection)
          .doc(docId)
          .collection(timeOfDay);

      await studentsRef.add({
        'name': studentName,
        'rollno': 'BSIT' + rollNo,
        'address': address,
        'fathername': fatherName,
        'phone': phone,
        'quiz': quiz,
        'isassignmentdone': assignment,
        'ispresent': present,
        'totalpresent': total,
        'totalassign': total,
        'totalquiz': total
      });

      print(
          'Student data added successfully under semester ID $docId, in the $timeOfDay session!');
      setState(() {
        studentNameController.clear();
        rollNoController.clear();
        addressController.clear();
        fatherNameController.clear();
        phoneController.clear();
      });
    } catch (e) {
      print('Error adding student: $e');
    }
  }

  Future<String?> fetchSingleDocumentId(String collection) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collection).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        print('No document found in the collection: $collection');
        return null;
      }
    } catch (e) {
      print('Error fetching document ID: $e');
      return null;
    }
  }

  void getDocumentId(String collectionName) async {
    docId = await fetchSingleDocumentId(collectionName);
    if (docId != null) {
      print('Document ID in $collectionName is: $docId');
    } else {
      print(
          'No document found or error occurred in collection: $collectionName');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 140, 73, 215),
        title: Text('Student Form'),
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
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Student Name',
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
                            color: Color.fromARGB(255, 140, 73, 215)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 73, 215),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    controller: studentNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Student name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Student Rollno',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the rounded corner radius here
                      ),
                      prefixIcon: Icon(
                        Icons.numbers,
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
                    controller: rollNoController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Student roll number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter Student Address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Student Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the rounded corner radius here
                      ),
                      prefixIcon: Icon(
                        Icons.location_on,
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
                    controller: addressController,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter Student Father\'s Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Student Father\'s Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the rounded corner radius here
                      ),
                      prefixIcon: Icon(
                        Icons.person_2,
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
                    controller: fatherNameController,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Student Phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the rounded corner radius here
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
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
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Student phone number';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: _selectedCollection,
                        hint: Text('Semester',
                            style: TextStyle(
                                color: Color.fromARGB(255, 140, 73, 215))),
                        items: collections.map((String collection) {
                          return DropdownMenuItem<String>(
                            value: collection,
                            child: Text(collection,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 140, 73, 215))),
                          );
                        }).toList(),
                        onChanged: (collection) {
                          setState(() {
                            _selectedCollection = collection;
                            getDocumentId(_selectedCollection!);
                          });
                        },
                        dropdownColor: Colors.white,
                      ),
                      SizedBox(width: 30),
                      DropdownButton<String>(
                        value: _selectedItem,
                        hint: Text('Programme',
                            style: TextStyle(
                                color: Color.fromARGB(255, 140, 73, 215))),
                        items: items1.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 140, 73, 215))),
                          );
                        }).toList(),
                        onChanged: (item) {
                          setState(() {
                            _selectedItem = item;
                          });
                        },
                        dropdownColor: Colors.white,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          addStudentDirectly(
                            _selectedCollection!,
                            _selectedItem!,
                            studentNameController.text,
                            rollNoController.text,
                            addressController.text,
                            fatherNameController.text,
                            phoneController.text,
                            quiz,
                            assignment,
                            present,
                            0,
                            0,
                            0,
                          );
                          print('Student Name: $studentName');
                          print('Roll No: $rollNo');
                          print('Address: $address');
                          print('Father\'s Name: $fatherName');
                          print('Phone: $phone');
                          print('Quiz: $quiz');
                          print('Assignment: $assignment');
                          print('Present: $present');
                        }
                      },
                      child: Text('Add Student'),
                    ),
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
