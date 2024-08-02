import 'package:attendenceapp/admin/addteach.dart';
import 'package:attendenceapp/admin/addstd.dart';
import 'package:attendenceapp/admin/upstd.dart';
import 'package:attendenceapp/admin/upteach.dart';
import 'package:attendenceapp/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 140, 73, 215),
          title: const Text('Home',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
                onPressed: () async {
                  await _auth.signOut();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  prefs.remove('password');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 140, 73, 215),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.pending,
                ),
                title: Text('Accepted Appointments'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('History'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Image.asset(
                'assets/sp.png', // Path to your image
              ),
            ),
            Expanded(
              flex:
                  1, // Takes the remaining half of the screen space for the grid
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(16.0),
                childAspectRatio: 0.8,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => StudentFormPage())));
                    },
                    child: createLifestyleCard(
                        'assets/Student1.png', 'Add Students', ''),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: ((context) => UpStu())));
                    },
                    child: createLifestyleCard(
                        'assets/Student2.png', 'Update Student', ''),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => SignUpPage())));
                    },
                    child: createLifestyleCard(
                        'assets/Teacher1.png', 'Add Teachers', ''),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => TeacherListPage())));
                    },
                    child: createLifestyleCard(
                        'assets/Teacher2.png', 'Update Teachers', ''),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createLifestyleCard(String imagePath, String saleText, String text) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.purple,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      height: 150,
      width: 150,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
          ),
          // ElevatedButton(onPressed: () {}, child: Text(saleText))
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 140, 73, 215),
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            padding: EdgeInsets.symmetric(vertical: 8),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
              ),
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    saleText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 4),
                  // Text(
                  //   text,
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 14,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
