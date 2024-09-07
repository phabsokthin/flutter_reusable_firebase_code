import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailPassword(String email, String password, String displayName) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //store display Data
      await userCredential.user?.updateProfile(displayName: displayName);
      await userCredential.user?.reload();

      return userCredential.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
