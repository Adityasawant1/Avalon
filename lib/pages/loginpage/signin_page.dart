import 'package:avalon/pages/loginpage/signup_page.dart';
import 'package:avalon/theme/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
              child: Column(
                children: [
                  // Title
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 39,
                      color: textColor1,
                    ),
                  ),
                  // Subtitle
                  Text(
                    'Continue your journey towards a\n sustainable future',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor2,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Form(
                    key: _formkey,
                    child: Container(
                      width: size.width * 0.8,
                      child: Column(
                        children: [
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
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email'; // Return error message if email is empty
                              } else if (!EmailValidator.validate(value)) {
                                return 'Please enter a valid email'; // Return error message if email is invalid
                              }
                              return null; // Return null if email is valid
                            },
                            onChanged: (value) {
                              if (_formkey.currentState != null) {
                                _formkey.currentState!
                                    .validate(); // Validate form on text change
                              }
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          // Password Input Text Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText:
                                !_isPasswordVisible, // Toggle password visibility
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 22,
                              ),
                              hintText: "Enter Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible =
                                        !_isPasswordVisible; // Update password visibility state
                                  });
                                },
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter password"; // Return error message if password is empty
                              } else if (value.length < 8 ||
                                  value.length > 16) {
                                return "Password must be between 8 and 16 characters"; // Return error message if password length is invalid
                              }
                              return null; // Return null if password is valid
                            },
                            onChanged: (value) {
                              if (_formkey.currentState != null) {
                                _formkey.currentState!
                                    .validate(); // Validate form on text change
                              }
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          // Recover Password Button
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Recover Password",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: textColor2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          // Sign In Button
                          GestureDetector(
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                // Validate form
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                  child: Text("Sign In",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
