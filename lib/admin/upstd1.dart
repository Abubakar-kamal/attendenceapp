import 'package:attendenceapp/model/firestoremodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  final String? collection;
  final String? subcollection;

  const StudentScreen({super.key, this.collection, this.subcollection});
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final StudentService _studentService = StudentService();
  List<Student> _students = [];
  bool _isLoading = true;
  String? _documentId;
  @override
  void initState() {
    super.initState();
    _fetchDocumentId();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    List<Student> fetchedStudents =
        await _studentService.fetchStudentsFromSubCollection(
            widget.collection!, widget.subcollection!);

    setState(() {
      _students = fetchedStudents;
      // Sort students by roll number
      _students.sort((a, b) => a.rollno.compareTo(b.rollno));
      _isLoading = false;
    });
  }

  Future<void> _fetchDocumentId() async {
    String? documentId = await _studentService
        .getFirstDocumentId(widget.collection!); // Example collection name
    setState(() {
      _documentId = documentId;
      _isLoading = false;
    });
  }

  void _updateStudent(
    String name,
    String rollNo,
    String address,
    String father,
    String phone,
  ) async {
    try {
      await _studentService.updateStudent(widget.collection!, _documentId!,
          widget.subcollection!, name, rollNo, address, father, phone);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student information updated')),
      );

      setState(() {
        _isLoading = true;
      });
      await _fetchStudents();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update student: $e')),
      );
    }
  }

  void _deleteStudent(String rollNo) async {
    try {
      await _studentService.deleteStudent(
          widget.collection!, widget.subcollection!, _documentId!, rollNo);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student deleted')),
      );

      setState(() {
        _isLoading = true;
      });
      await _fetchStudents();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete student: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Students'),
        backgroundColor: Color.fromRGBO(218, 211, 245, 1),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
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
                ListView.builder(
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    Student student = _students[index];
                    return ListTile(
                      title: Text(student.studentname),
                      subtitle: Text(student.rollno),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Open a dialog or navigate to a new screen for updating
                              _showUpdateDialog(student);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteStudent(student.rollno);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }

  void _showUpdateDialog(Student student) {
    final TextEditingController nameController =
        TextEditingController(text: student.studentname);
    final TextEditingController rollNoController =
        TextEditingController(text: student.rollno);
    final TextEditingController addressController =
        TextEditingController(text: student.address);
    final TextEditingController fatherController =
        TextEditingController(text: student.father);
    final TextEditingController phoneController =
        TextEditingController(text: student.phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Student'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: rollNoController,
                decoration: InputDecoration(labelText: 'Roll No'),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: fatherController,
                decoration: InputDecoration(labelText: 'Father Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _updateStudent(
                    nameController.text,
                    rollNoController.text,
                    addressController.text,
                    fatherController.text,
                    phoneController.text);
              });

              Navigator.of(context).pop();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
