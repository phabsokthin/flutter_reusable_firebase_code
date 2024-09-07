import 'package:cloud_firestore/cloud_firestore.dart';

class Getcollectionbyid{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch a document by ID
  Future<Map<String, dynamic>?> getDocumentById(String collectionName, String docId) async {
    try {
      DocumentSnapshot docSnapshot = await _firestore.collection(collectionName).doc(docId).get();
      if (docSnapshot.exists) {
        return {
          'id': docSnapshot.id,
          ...docSnapshot.data() as Map<String, dynamic>,
        };
      } else {
        print("Document not found");
        return null;
      }
    } catch (e) {
      print("Error getting document: $e");
      return null;
    }
  }
}