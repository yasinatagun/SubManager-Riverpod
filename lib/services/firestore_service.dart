import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> getUserName(String userId) async {
    try {
      var doc = await _db.collection('users').doc(userId).get();
      return doc.data()?['name'] ?? 'No Name';
    } catch (e) {
      return 'No Name'; // Handle errors or return a default value
    }
  }


}
