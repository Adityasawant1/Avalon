import 'package:avalon/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      // Create a new user with email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // Generate a unique user ID
        String userId = _firestore.collection('users').doc().id;

        // Store the user data in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'userId': userId,
          'email': email,
        });

        // Save the user ID locally for later use
        await UserModel.saveUserId(userId);

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
