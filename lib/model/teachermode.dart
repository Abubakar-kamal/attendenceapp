import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? currentUser;
  String user = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<Teacher> fetchTeacher(var uid) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('teachers').doc(uid).get();
      return Teacher.fromMap(
          snapshot.data() as Map<String, dynamic>, snapshot.id);
    } catch (e) {
      throw Exception('Error fetching teacher data: $e');
    }
  }
}

class Teacher {
  final String id;
  final String name;
  final String subject;
  final String email;
  final String teacher;

  Teacher({
    required this.id,
    required this.name,
    required this.subject,
    required this.email,
    required this.teacher,
  });

  factory Teacher.fromMap(Map<String, dynamic> data, String id) {
    return Teacher(
      id: id,
      name: data['name'] ?? '',
      subject: data['course'] ?? '',
      email: data['email'] ?? '',
      teacher: data['teacherId'],
    );
  }
}
