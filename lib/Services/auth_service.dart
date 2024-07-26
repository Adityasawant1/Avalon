// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        return "success";
      } else {
        return "An unknown error occurred.";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email is already registered. Please sign in.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
