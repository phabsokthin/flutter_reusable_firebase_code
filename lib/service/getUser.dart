
import 'package:firebase_auth/firebase_auth.dart';

class GetUserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Check if a user is signed in
  bool isUserSignedIn() {
    return _auth.currentUser != null;
  }

  // Get the user ID
  String? getUserId() {
    return _auth.currentUser?.uid;
  }

  String? displayName(){
    return _auth.currentUser?.displayName;
  }
  // Get the user email
  String? getUserEmail() {
    return _auth.currentUser?.email;
  }


}
