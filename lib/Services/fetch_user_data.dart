import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchUserData extends StatelessWidget {
  final Widget child;

  FetchUserData({required this.child});

  Future<Map<String, dynamic>> _fetchUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return {
          'username': userDoc['username'] ?? '',
          'email': user.email!,
          'profile_picture': userDoc['profile_picture'] ?? '',
        };
      }
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text('Error fetching user data'),
            ),
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return UserDataProvider(
            userData: snapshot.data!,
            child: child,
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Text('No user data available'),
          ),
        );
      },
    );
  }
}

class UserDataProvider extends InheritedWidget {
  final Map<String, dynamic> userData;

  UserDataProvider({required this.userData, required Widget child})
      : super(child: child);

  static UserDataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserDataProvider>();
  }

  @override
  bool updateShouldNotify(UserDataProvider oldWidget) {
    return oldWidget.userData != userData;
  }
}
