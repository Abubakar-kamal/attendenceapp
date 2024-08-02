import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StudentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Student>> fetchStudentsFromSubCollection(
      String mainCollection, String subCollection) async {
    List<Student> students = [];
    try {
      // First get all documents in the main collection
      QuerySnapshot mainCollectionSnapshot =
          await _firestore.collection(mainCollection).get();

      // Then fetch each subcollection for each document
      for (var doc in mainCollectionSnapshot.docs) {
        String docId = doc.id;
        QuerySnapshot subCollectionSnapshot = await _firestore
            .collection('$mainCollection/$docId/$subCollection')
            .get();
        for (var subDoc in subCollectionSnapshot.docs) {
          students.add(Student.fromFirestore(subDoc));
        }
      }
    } catch (e) {
      print('Error fetching students: $e');
    }
    return students;
  }

  Future<void> createDocumentWithTodayDate(
    String mcollection,
    String subcollection,
    String studentName,
    String rollNo,
    String address,
    String fatherName,
    String phone,
    int quiz,
    bool isAssignmentDone,
    bool isPresent,
    int totalPresent,
    int totalQuiz,
    int totalAssign,
  ) async {
    // Get today's date in 'yyyy-MM-dd' format
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Reference to Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Step 1: Reference to the collection with today's date
    CollectionReference dateCollectionRef = firestore.collection(todayDate);

    // Step 2: Create or get the 'semester' document under the date collection
    DocumentReference semesterDocRef = dateCollectionRef.doc(mcollection);

    // Set the 'semester' document with an empty map (to ensure it exists)
    await semesterDocRef.set(<String, dynamic>{});

    // Step 3: Prepare the data to be saved
    Map<String, dynamic> morningData = {
      'name': studentName ?? 'No Name',
      'rollno': rollNo ?? 'N/A',
      'address': address ?? 'N/A',
      'fathername': fatherName,
      'phone': phone,
      'quiz': quiz,
      'isassignmentdone': isAssignmentDone,
      'ispresent': isPresent,
      'totalpresent': totalPresent,
      'totalquiz': totalQuiz,
      'totalassign': totalAssign,
    };

    // Step 4: Add the data to the 'morning' subcollection under the 'semester' document
    DocumentReference morningDocRef =
        await semesterDocRef.collection(subcollection).add(morningData);

    // Optionally print the IDs of the new documents
    print("Data added in 'morning' with ID: ${morningDocRef.id}");
  }

  Future<void> updateStudent(
    String collectionName,
    String documentId,
    String subCollectionName,
    String name,
    String rollNo,
    String address,
    String father,
    String phone,
  ) async {
    try {
      // Fetch the document with the given rollNo in the subcollection
      QuerySnapshot snapshot = await _firestore
          .collection(collectionName)
          .doc(documentId)
          .collection(subCollectionName)
          .where('rollno', isEqualTo: rollNo)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Assuming roll numbers are unique, there should be only one document
        DocumentSnapshot studentDoc = snapshot.docs.first;
        // Update the totalAbsent field
        await _firestore
            .collection(collectionName)
            .doc(documentId)
            .collection(subCollectionName)
            .doc(studentDoc.id)
            .update({
          'name': name,
          'rollno': rollNo,
          'address': address,
          'fathername': father,
          'phone': phone,
        });
        print("Successfully updated totalAbsent for roll number $rollNo");
      } else {
        print("No student found with roll number $rollNo");
      }
    } catch (e) {
      print('Error updating student totalAbsent: $e');
    }
  }

  Future<void> deleteStudent(String collection, String subcollection,
      String docid, String rollNo) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(collection)
        .doc(docid) // Use your document ID
        .collection(subcollection)
        .where('rollno', isEqualTo: rollNo)
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<List<Student>> fetchDataFromFirestore(
      String date, String mcollection, String subcollection) async {
    List<Student> students = [];

    // Get today's date in 'yyyy-MM-dd' format
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Step 1: Reference to the collection with today's date
    CollectionReference dateCollectionRef = _firestore.collection(date);

    // Step 2: Get the 'semester' document
    DocumentReference semesterDocRef = dateCollectionRef.doc(mcollection);

    // Step 3: Get the data from the 'morning' subcollection
    QuerySnapshot morningSnapshot =
        await semesterDocRef.collection(subcollection).get();

    // Step 4: Iterate through the documents and parse them into Student objects
    for (QueryDocumentSnapshot doc in morningSnapshot.docs) {
      students.add(Student.fromFirestore(doc));
    }

    return students;
  }

//Fetch doc id
  Future<String?> getFirstDocumentId(String collectionName) async {
    try {
      // Attempt to fetch the first document from the specified collection
      QuerySnapshot snapshot =
          await _firestore.collection(collectionName).limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        // Return the ID of the first document
        return snapshot.docs.first.id;
      } else {
        // Return null if no documents are found
        print('No documents found in the collection $collectionName');
        return null;
      }
    } catch (e) {
      print('Error fetching first document ID from $collectionName: $e');
      return null;
    }
  }
}

class Student {
  String studentname;
  String rollno;
  String address;
  String father;
  String phone;
  bool quiz;
  bool assignment;
  bool present;
  int total;
  int quizt;
  int assign;

  Student({
    required this.studentname,
    required this.rollno,
    required this.address,
    required this.father,
    required this.phone,
    required this.quiz,
    required this.assignment,
    required this.present,
    required this.total,
    required this.quizt,
    required this.assign,
  });

  factory Student.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Student(
      studentname: data['name'] ?? 'No Name',
      rollno: data['rollno'] ?? 'N/A',
      address: data['address'] ?? 'N/A',
      father: data['fathername'] ?? '',
      phone: data['phone'] ?? '',
      quiz: data['quiz'] is bool ? data['quiz'] : false,
      assignment:
          data['isassignmentdone'] is bool ? data['isassignmentdone'] : false,
      present: data['ispresent'] is bool ? data['ispresent'] : false,
      total: data['totalpresent'] is int ? data['totalpresent'] : 0,
      quizt: data['totalquiz'] is int ? data['totalquiz'] : 0,
      assign: data['totalassign'] is int ? data['totalassign'] : 0,
    );
  }
}
