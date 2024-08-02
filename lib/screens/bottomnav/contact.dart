// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  void launchWhatsApp() async {
    var whatsappUrl =
        "whatsapp://send?phone=+923062424347"; // Replace with the phone number
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  void launchCall() async {
    var phoneUrl = "tel:+923062424347"; // Replace with the phone number
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }

  void launchEmail() async {
    final emailUrl =
        "mailto:ahmadsafdar5.com?subject=Sample Subject&body=Sample Body"; // Replace with actual email address
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    var icon = null;
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 216, 205, 230),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 140, 73, 215),
        title: Text(
          'Contact Us',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Image.asset("assets/10.webp", height: 200),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 450,
              height: 200,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Developer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: launchWhatsApp,
                      icon: Icon(Icons.wechat_sharp),
                      label: Text('Contact on WhatsApp'),
                    ),
                    ElevatedButton.icon(
                      onPressed: launchCall,
                      icon: Icon(Icons.call),
                      label: Text('Call Us'),
                    ),
                    ElevatedButton.icon(
                      onPressed: launchEmail,
                      icon: Icon(Icons.email),
                      label: Text('Send Email'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 450,
              height: 200,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Authoroties',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: launchWhatsApp,
                      icon: Icon(Icons.chat),
                      label: Text(
                        'Contact on WhatsApp',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: launchCall,
                      icon: Icon(Icons.call),
                      label: Text('Call Us'),
                    ),
                    ElevatedButton.icon(
                      onPressed: launchEmail,
                      icon: Icon(Icons.email),
                      label: Text('Send Email'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
