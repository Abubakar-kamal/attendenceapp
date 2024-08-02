import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About This App'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 140, 73, 215),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'About the Application',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 140, 73, 215),
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'This Application is made on the Flutter framework and is developed by Muhammad Ahmad Ali as a Final Year Project for the Bahauddin Zakariya University.\nIt is created as per the need of the Department and upon the desire of the Supervisor Dr. Sarah Bukhari.',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
