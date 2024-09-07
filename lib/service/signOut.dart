import 'package:firebase_auth/firebase_auth.dart';

class SignoutService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Sign out the user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print('Error signing out: $error');
    }
  }
}
