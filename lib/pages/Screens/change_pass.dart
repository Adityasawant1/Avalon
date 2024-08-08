import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  String _errorMessage = '';
  String _successMessage = '';

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade100,
              Colors.white,
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
                TweenAnimationBuilder(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeIn,
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double opacity, child) {
                    return Opacity(
                      opacity: opacity,
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 39,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Current Password Input Field
                      TweenAnimationBuilder(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn,
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double opacity, child) {
                          return Opacity(
                            opacity: opacity,
                            child: child,
                          );
                        },
                        child: TextFormField(
                          controller: _currentPasswordController,
                          obscureText: !_isCurrentPasswordVisible,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 22,
                            ),
                            hintText: "Enter Current Password",
                            labelText: "Current Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isCurrentPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isCurrentPasswordVisible =
                                      !_isCurrentPasswordVisible;
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
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      // New Password Input Field
                      TweenAnimationBuilder(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn,
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double opacity, child) {
                          return Opacity(
                            opacity: opacity,
                            child: child,
                          );
                        },
                        child: TextFormField(
                          controller: _newPasswordController,
                          obscureText: !_isNewPasswordVisible,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 22,
                            ),
                            hintText: "Enter New Password",
                            labelText: "New Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isNewPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isNewPasswordVisible =
                                      !_isNewPasswordVisible;
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
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Confirm Password Input Field
                      TweenAnimationBuilder(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn,
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double opacity, child) {
                          return Opacity(
                            opacity: opacity,
                            child: child,
                          );
                        },
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 22,
                            ),
                            hintText: "Confirm Password",
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
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your new password';
                            }
                            if (value != _newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
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
                      // Change Password Button
                      TweenAnimationBuilder(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn,
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double opacity, child) {
                          return Opacity(
                            opacity: opacity,
                            child: child,
                          );
                        },
                        child: GestureDetector(
                          onTap: _changePassword,
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
                                  color: backgroundColor2,
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
                                      "Change Password",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
        _successMessage = '';
      });

      try {
        User? user = FirebaseAuth.instance.currentUser;
        String email = user?.email ?? '';

        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: _currentPasswordController.text,
        );

        await user?.reauthenticateWithCredential(credential);
        await user?.updatePassword(_newPasswordController.text);

        setState(() {
          _isLoading = false;
          _successMessage = 'Password changed successfully!';
          _currentPasswordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();
        });

        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      } catch (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to change password: $error';
        });
      }
    }
  }
}

const backgroundColor2 = Color(0xFF274D46);
const backgroundColor4 = Color.fromARGB(255, 62, 93, 86);
const textColor1 = Colors.white;
const textColor2 = Color(0xFF789F8A);
const buttonColor = Color(0xFF4c7273);
