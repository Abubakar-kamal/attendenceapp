// ignore_for_file: prefer_const_constructors

import 'package:attendenceapp/screens/history2.dart';
import 'package:flutter/material.dart';
import 'package:attendenceapp/model/firestoremodel.dart'; // Import your model
// Import your service class

class FetchDataScreen extends StatefulWidget {
  final String? collection;
  final String? subcollection; // The collection name passed from MainPage
  final String? date;
  FetchDataScreen({
    Key? key,
    this.collection,
    this.subcollection,
    this.date,
  }) : super(key: key);
  @override
  _FetchDataScreenState createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
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
  @override
  void initState() {
    super.initState();

    _fetchStudents();
  }

  // Future<void> _fetchDocumentId() async {
  //   String? documentId = await _studentService
  //       .getFirstDocumentId(widget.collection!); // Example collection name
  //   setState(() {
  //     _documentId = documentId;
  //     _isLoading = false;
  //   });
  // }

  Future<void> _fetchStudents() async {
    List<Student> fetchedStudents =
        await _studentService.fetchDataFromFirestore(
            widget.date!, widget.collection!, widget.subcollection!);

    setState(() {
      students = fetchedStudents;
      // Sort students by roll number
      students.sort((a, b) => a.rollno.compareTo(b.rollno));
      _isLoading = false;
    });
  }

  // All fields are filled, perform action here

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
                        text: '${student.studentname}',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  )),
                  Text("RollNo : ${student.rollno}"),
                  Text("Address : ${student.address}"),
                  Text("Father Name : ${student.father}"),
                  Text("Phone Number : ${student.phone}"),
                  Text("Total Present : ${student.total}/30"),
                  Text("Total Assignment : ${student.total}"),
                  Text("Total Quiz : ${student.total}"),
                  Text("Total Absent : $abs"),
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
                        inc1 = student.quizt + 1;
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
                        inc2 = student.assign + 1;
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
      ),
      body: ListView.separated(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            subtitle: GestureDetector(
              onTap: () => _showStudentDetails(students[index]),
              child: Container(
                height: 150,
                child: Card(
                  elevation: 10,
                  shadowColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          IconButton(
                            icon: Icon(Icons.list_outlined),
                            onPressed: () => _showChecklist(
                              students[index],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ChoiceChip(
                            label: Text(students[index].present == true
                                ? 'Present'
                                : 'Absent'),
                            selected:
                                students[index].present == true ? true : false,
                            //backgroundColor: Colors.white,
                            selectedColor: students[index].present == false
                                ? Colors.red
                                : Colors.green,
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.white,
        ),
      ),
    );
  }
}
