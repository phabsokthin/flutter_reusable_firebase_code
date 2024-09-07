import 'package:cloud_firestore/cloud_firestore.dart';

class GetCollectionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getCollection(String collectionName) async {
    try {

      QuerySnapshot querySnapshot = await _firestore.collection(collectionName).get();
      List<Map<String, dynamic>> collectionData = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();

      return collectionData;
    } catch (e) {
      print("Error getting collection: $e");
      return [];
    }
  }
}
