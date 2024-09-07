import 'package:firebase_auth/firebase_auth.dart';

class Signinservice {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Return user ID on successful sign-in
    } catch (error) {
      return error.toString();
    }
  }
}
