import 'package:cloud_firestore/cloud_firestore.dart';

class DataMethod {
  final CollectionReference<Map<String, dynamic>> _studentCollection =
  FirebaseFirestore.instance.collection("student");


  Future<DocumentReference<Map<String, dynamic>>> addStudent(
      Map<String, dynamic> studentInfoMap) async {
    try {
      return await _studentCollection.add(studentInfoMap);
    } catch (e) {
      print("Error adding student: $e");
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStudents() {
    return _studentCollection.snapshots();
  }

  Future<void> updateStudent(String id, Map<String, dynamic> updateStudentInfo) async {
    try {
      return await _studentCollection.doc(id).update(updateStudentInfo);
    } catch (e) {
      print("Error updating student: $e");
      rethrow;
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      return await _studentCollection.doc(id).delete();
    } catch (e) {
      print("Error deleting student: $e");
      rethrow;
    }
  }
}
