import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reusable addDoc function
  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
    } catch (e) {
      print('Error adding document: $e');
    }
  }


  Future<void> deleteDocument(String collectionName, String docId) async {
    try {
      await _firestore.collection(collectionName).doc(docId).delete();
      print("Document with ID $docId deleted successfully.");
    } catch (e) {
      print("Error deleting document: $e");
    }
  }

  // Method to update a document in Firestore
  Future<void> updateDocument(String collectionName, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).doc(docId).update(data);
      print("Document updated successfully");
    } catch (e) {
      print("Error updating document: $e");
    }
  }

}
