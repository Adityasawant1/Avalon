//import 'package:avalon/pages/loginpage/intro_page.dart';
import 'package:avalon/pages/loginpage/signin_page.dart';
//import 'package:avalon/pages/loginpage/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avalon ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const SignInPage(),
    );
  }
}
