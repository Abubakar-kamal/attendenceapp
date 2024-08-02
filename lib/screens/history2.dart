import 'package:attendenceapp/screens/history.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

// Import your updated service class

class History extends StatefulWidget {
  final String? collection;
  final String? subcollection; // The collection name passed from MainPage

  History({
    Key? key,
    required this.collection,
    required this.subcollection,
  }) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool isfalse = false;
  bool isfalse1 = false;

  DateTime? _selectedDate;
  String _formattedDate = "";

  void _openDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
        isfalse = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(""),
        backgroundColor: Color.fromARGB(255, 140, 73, 215),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 50),
                Image.asset("assets/hi.png", height: 200),
                SizedBox(height: 80),
                IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    size: 50.0,
                    color: Colors.purple,
                  ),
                  onPressed: () => _openDatePicker(context),
                ),
                SizedBox(height: 20),
                Text(
                  _selectedDate == null
                      ? 'No date selected!'
                      : 'Selected date: $_formattedDate',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                SizedBox(height: 100),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // Pass the selected collection to the AttendancePage
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Profile()),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FetchDataScreen(
                            date: _formattedDate.toString(),
                            collection: widget.collection,
                            subcollection: widget.subcollection,
                          ),
                        ),
                      );
                    },
                    child: Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
