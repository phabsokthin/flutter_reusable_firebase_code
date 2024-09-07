import 'package:cloud_firestore/cloud_firestore.dart';

class Getcollectionsearch {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> searchCollection(
      String collectionName, String searchField, String searchQuery) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(collectionName)
          .where(searchField, isGreaterThanOrEqualTo: searchQuery.toLowerCase())
          .where(searchField,
              isLessThanOrEqualTo: '${searchQuery.toLowerCase()}\uf8ff')
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id, // Include document ID
          ...data,
        };
      }).toList();
    } catch (e) {
      print("Error searching collection: $e");
      return [];
    }
  }
}
