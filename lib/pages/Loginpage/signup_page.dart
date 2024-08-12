import 'package:avalon/Services/google_auth_service.dart';
import 'package:avalon/pages/Home/main_home_page.dart';
import 'package:avalon/pages/Loginpage/signin_page.dart';
import 'package:avalon/theme/colors.dart';
import 'package:avalon/utils/social_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  String _errorMessage = '';
  String _successMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor2,
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                // Title
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 39,
                    color: textColor1,
                  ),
                ),
                // Subtitle
                Text(
                  'Join us and start your journey\n towards a sustainable future',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor2,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Enter Username Input Field
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Enter Username",
                          labelText: "Username",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKey.currentState != null) {
                            _formKey.currentState!.validate();
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Enter Email Input Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Enter Email",
                          labelText: "Email",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKey.currentState != null) {
                            _formKey.currentState!.validate();
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Password Input Text Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Enter Password",
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          } else if (value.length < 8 || value.length > 16) {
                            return "Password must be between 8 and 16 characters";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKey.currentState != null) {
                            _formKey.currentState!.validate();
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Confirm Password Input Text Field
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Same as password",
                          labelText: "Confirm Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          } else if (value != _passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKey.currentState != null) {
                            _formKey.currentState!.validate();
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.05),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      if (_successMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            _successMessage,
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      // Sign Up Button
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                              _errorMessage = '';
                              _successMessage = '';
                            });
                            AuthService authService = AuthService();
                            var result =
                                await authService.registerWithEmailAndPassword(
                              _emailController.text,
                              _passwordController.text,
                              _usernameController.text,
                            );
                            setState(() {
                              _isLoading = false;
                            });
                            if (result == "success") {
                              setState(() {
                                _successMessage = 'Successfully registered!';
                                _emailController.clear();
                                _passwordController.clear();
                                _confirmPasswordController.clear();
                                _usernameController.clear();
                              });
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                );
                              });
                            } else if (result ==
                                'Email is already registered. Please sign in.') {
                              setState(() {
                                _errorMessage = result;
                              });
                            } else {
                              setState(() {
                                _errorMessage =
                                    'Sign up failed. Please try again.';
                              });
                            }
                          }
                        },
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 0.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Center(
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      width: size.width * 0.2,
                      color: Colors.black12,
                    ),
                    Text(
                      "  Or SignUp with   ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor2,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      height: 2,
                      width: size.width * 0.2,
                      color: Colors.black12,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SocialMediaButton(
                      onpress: () async {
                        UserCredential user =
                            await GoogleAuthService().signInWithGoogle();
                        // ignore: unnecessary_null_comparison
                        if (user != null) {
                          // Successful sign-in
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        } else {
                          // Sign-in failed
                          print("Sign-in failed");
                        }
                      },
                      imagePath: "assets/images/google.png",
                      backgroundColor: backgroundColor4,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.035),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: size.width * 0.01),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ),
                        );
                      },
                      child: const Text(
                        " Sign In",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'username': username,
        });
        return 'success';
      } else {
        return 'Sign up failed. Please try again.';
      }
    } catch (e) {
      if (e.toString().contains('email-already-in-use')) {
        return 'Email is already registered. Please sign in.';
      }
      return 'Sign up failed. Please try again.';
    }
  }
}
