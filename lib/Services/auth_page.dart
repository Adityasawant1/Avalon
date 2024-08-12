import 'package:avalon/pages/Home/main_home_page.dart';
import 'package:avalon/pages/Loginpage/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, Snapshot) {
          if (Snapshot.hasData) {
            return MainScreen();
          } else {
            return const IntroPage();
          }
        },
      ),
    );
  }
}
