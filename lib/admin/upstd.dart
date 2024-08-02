// ignore_for_file: prefer_const_constructors

import 'package:attendenceapp/admin/upstd1.dart';
import 'package:flutter/material.dart';

// Import your updated service class

class UpStu extends StatefulWidget {
  const UpStu({super.key});

  @override
  State<UpStu> createState() => _UpStuState();
}

class _UpStuState extends State<UpStu> {
  String? _selectedItem;
  String? _selectedItem1;
  String? _selectedCollection; // For collection selection
  bool isfalse = false;
  bool isfalse1 = false;

  List<String> items1 = ["Morning", "Evening"];
  List<String> collections = [
    'Semester1',
    'Semester3',
    'Semester5',
    'Semester7',
  ]; // Collections

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(""),
        backgroundColor: Color.fromRGBO(218, 211, 245, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Center(
              //   child: Container(
              //     height: 450,
              //     width: 380,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage("assets/sp.png"),
              //           colorFilter: ColorFilter.mode(
              //             Colors.white.withOpacity(
              //                 0.7), // Adjust opacity to make the image lighter
              //             BlendMode.lighten,
              //           )),
              //     ),
              //   ),
              // ),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Image.asset("assets/11.png", height: 200),
                    SizedBox(height: 80),
                    Text('Select Semester',
                        style: TextStyle(color: Colors.black, fontSize: 22)),
                    DropdownButton<String>(
                      value: _selectedCollection,
                      hint: Text('Semester',
                          style: TextStyle(color: Colors.purple)),
                      items: collections.map((String collection) {
                        return DropdownMenuItem<String>(
                          value: collection,
                          child: Text(collection,
                              style: TextStyle(color: Colors.purple)),
                        );
                      }).toList(),
                      onChanged: (collection) {
                        setState(() {
                          _selectedCollection = collection;

                          isfalse = true;
                        });
                      },
                      dropdownColor: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text('Select Programme',
                        style: TextStyle(color: Colors.black, fontSize: 22)),
                    DropdownButton<String>(
                      value: _selectedItem,
                      hint: Text('Programme',
                          style: TextStyle(color: Colors.purple)),
                      items: items1.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                              style: TextStyle(color: Colors.purple)),
                        );
                      }).toList(),
                      onChanged: (item) {
                        setState(() {
                          _selectedItem = item;
                          isfalse1 = true;
                        });
                      },
                      dropdownColor: Colors.white,
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
                        onPressed: isfalse && isfalse1
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentScreen(
                                      collection: _selectedCollection,
                                      subcollection: _selectedItem,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        child: Text('Next'),
                      ),
                    ),
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
