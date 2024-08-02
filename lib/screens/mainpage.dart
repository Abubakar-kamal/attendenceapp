// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:attendenceapp/screens/attend.dart';
import 'package:attendenceapp/auth/login.dart';

import 'package:attendenceapp/screens/bottomnav/contact.dart';
import 'package:attendenceapp/screens/bottomnav/profile.dart';
import 'package:attendenceapp/screens/bottomnav/settings.dart';

// Import your updated service class

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home '),
    Text('Settings '),
    Text('Profile '),
    Text('Privacy Policy '),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Optionally, navigate to a different page or perform other actions based on index
    if (index == 0) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => MainPage()),
      // );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Settings()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContactPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
    }
    // } else if (index == 3) {
    //   _onLogoutTapped();
    // }
  }

  void _onLogoutTapped() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
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
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                  Image.asset("assets/13.jpg", height: 200),
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
                  Text('Select Semester',
                      style: TextStyle(color: Colors.black, fontSize: 22)),
                  DropdownButton<String>(
                    value: _selectedItem,
                    hint: Text('Programme',
                        style: TextStyle(color: Colors.purple)),
                    items: items1.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child:
                            Text(item, style: TextStyle(color: Colors.purple)),
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
                              // Pass the selected collection to the AttendancePage
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Profile()),
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AttendancePage(
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
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
            BottomNavigationBarItem(
                icon: Icon(Icons.call), label: 'Contact Us'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primaryContainer,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
