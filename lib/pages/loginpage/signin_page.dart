import 'package:avalon/pages/loginpage/forgot_pass.dart';
import 'package:avalon/pages/loginpage/signup_page.dart';
import 'package:avalon/theme/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  bool _isLoading = false;

  void signUserIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Fluttertoast.showToast(
        msg: "Login successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Navigate to home page after successful login
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // The account already exists with a different credential
        String email = e.email!;
        AuthCredential pendingCredential = e.credential!;

        // Fetch a list of what sign-in methods exist for the conflicting user
        List<String> userSignInMethods =
            // ignore: deprecated_member_use
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        // If the user has several sign-in methods,
        // the first method in the list will be the "recommended" method to use.
        if (userSignInMethods.first == 'password') {
          // Prompt the user to enter their password
          String password = '...'; // Replace with user input for password

          // Sign the user in to their account with the password
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Link the pending credential with the existing account
          await userCredential.user?.linkWithCredential(pendingCredential);

          // Success! Go back to your application flow
          Fluttertoast.showToast(
            msg: "Login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (userSignInMethods.first == 'facebook.com') {
          // Handle other OAuth providers like Facebook
          // Create a new Facebook credential
          String accessToken = await triggerFacebookAuthentication();
          var facebookAuthCredential =
              FacebookAuthProvider.credential(accessToken);

          // Sign the user in with the credential
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);

          // Link the pending credential with the existing account
          await userCredential.user?.linkWithCredential(pendingCredential);

          // Success! Go back to your application flow
          Fluttertoast.showToast(
            msg: "Login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        // Handle other OAuth providers...
      } else if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "Email incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Password incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "An error occurred. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> triggerFacebookAuthentication() async {
    // Simulate a Facebook authentication process
    await Future.delayed(Duration(seconds: 2));
    return 'facebook_access_token';
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
                SizedBox(height: size.height * 0.1),
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
                SizedBox(height: size.height * 0.06),
                Form(
                  key: _formkey,
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
                          labelText: "Email",
                          hintText: "Enter Email",
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
                          if (_formkey.currentState != null) {
                            _formkey.currentState!.validate();
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      // Password Input Text Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          labelText: "Password",
                          hintText: "Enter Password",
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
                          if (_formkey.currentState != null) {
                            _formkey.currentState!.validate();
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Recover Password Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordPage()));
                          },
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
                      SizedBox(height: size.height * 0.05),
                      // Sign In Button
                      GestureDetector(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            signUserIn();
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
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2,
                            width: size.width * 0.2,
                            color: Colors.black12,
                          ),
                          Text(
                            "  Or continue with   ",
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
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                        color: backgroundColor4,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 0.5,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(14),
                        child: Image(
                          image: AssetImage("assets/images/google.png"),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                        color: backgroundColor4,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 0.5,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(13),
                        child: Image(
                          image: AssetImage("assets/images/apple.png"),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                        color: backgroundColor4,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 0.5,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(13),
                        child: Image(
                          image: AssetImage("assets/images/facebook.png"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not a member?",
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
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        " Register Now",
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
