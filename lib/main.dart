import 'package:attendenceapp/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      projectId: "attendence-ef47b",
      apiKey: "AIzaSyC8wy05JHYLaR4k1nDSD9ZtUecQuZN9JX8",
      appId: "1:263257301508:android:2589d5d05c3b937d6e0b51",
      messagingSenderId: "263257301508",
      storageBucket: "attendence-ef47b.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendence App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 93, 36, 157),
        ),
        primaryColor: const Color.fromARGB(255, 93, 36, 157),
        useMaterial3: true,
      ),
      home: const Splashscreen(),
    );
  }
}
