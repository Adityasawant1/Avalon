import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AppColors1 {
  static const Color backgroundColor = Color(0xFF274D46);
  static const Color avatarBackgroundColor = Color(0xFF789F8A);
  static const Color weatherContainerColor = Color(0xFF51776F);
  static const Color exploreTabSelectedColor = Colors.white;
  static const Color exploreTabUnselectedColor = Color(0xFF789F8A);
  static const Color textWhite = Colors.white;
  static const Color textBlack = Colors.black;
  static const Color deviceContainerColor = Color(0xFF789F8A);
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  String _username = '';
  String _email = '';
  File? _imageFile;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _email = _user!.email!;
      _fetchUserInfo();
    }
  }

  Future<void> _fetchUserInfo() async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(_user!.uid).get();
    if (userDoc.exists) {
      setState(() {
        _username = userDoc['username'] ?? '';
        // _imageFile = userDoc['profile_picture'] != null
        //     ? File(userDoc['profile_picture'])
        //     : null;
      });
    }
  }

  Future<void> _updateUserInfo() async {
    await _firestore.collection('users').doc(_user!.uid).set({
      'username': _username,
      'profile_picture': _imageFile?.path,
    }, SetOptions(merge: true));
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors1.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors1.backgroundColor,
              floating: true,
              pinned: false,
              snap: true,
              elevation: 0,
              title: Center(
                child: Text(
                  "Profile",
                  style: TextStyle(
                      color: AppColors1.textWhite,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: AppColors1.avatarBackgroundColor,
                    child: IconButton(
                      icon: Icon(Icons.edit, color: AppColors1.textWhite),
                      onPressed: () {
                        setState(() {
                          _isEditing = !_isEditing;
                        });
                      },
                    ),
                  ),
                ),
              ],
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors1.avatarBackgroundColor,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors1.textWhite),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: UserInfoSection(
                        username: _username,
                        email: _email,
                        imageFile: _imageFile,
                        isEditing: _isEditing,
                        onUsernameChanged: (value) {
                          setState(() {
                            _username = value;
                          });
                        },
                        onImagePicked: _pickImage,
                      ),
                    ),
                    SizedBox(height: 20),
                    AccountSettingsSection(),
                    SizedBox(height: 20),
                    OtherDetailsSection(onSignOut: _signOut),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  final String username;
  final String email;
  final File? imageFile;
  final bool isEditing;
  final Function(String) onUsernameChanged;
  final Function onImagePicked;

  UserInfoSection({
    required this.username,
    required this.email,
    required this.imageFile,
    required this.isEditing,
    required this.onUsernameChanged,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double avatarRadius = constraints.maxWidth * 0.15;
        double fontSizeName = constraints.maxWidth * 0.07;
        double fontSizeEmail = constraints.maxWidth * 0.04;

        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors1.weatherContainerColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => onImagePicked(),
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : AssetImage('assets/images/profile.png')
                          as ImageProvider,
                ),
              ),
              SizedBox(height: 10),
              isEditing
                  ? TextFormField(
                      initialValue: username,
                      decoration: InputDecoration(
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: AppColors1.textWhite),
                      ),
                      style: TextStyle(
                          color: AppColors1.textWhite, fontSize: fontSizeName),
                      onChanged: onUsernameChanged,
                    )
                  : Text(
                      username,
                      style: TextStyle(
                          color: AppColors1.textWhite, fontSize: fontSizeName),
                    ),
              SizedBox(height: 5),
              Text(
                email,
                style: TextStyle(
                    color: AppColors1.textWhite, fontSize: fontSizeEmail),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AccountSettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSizeTitle = constraints.maxWidth * 0.05;
        double fontSizeItem = constraints.maxWidth * 0.04;

        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors1.weatherContainerColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Settings",
                style: TextStyle(
                    color: AppColors1.textWhite, fontSize: fontSizeTitle),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.lock, color: AppColors1.textWhite),
                title: Text(
                  "Change Password",
                  style: TextStyle(
                      color: AppColors1.textWhite, fontSize: fontSizeItem),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: AppColors1.textWhite),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.email, color: AppColors1.textWhite),
                title: Text(
                  "Change Email",
                  style: TextStyle(
                      color: AppColors1.textWhite, fontSize: fontSizeItem),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: AppColors1.textWhite),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

class OtherDetailsSection extends StatelessWidget {
  final Function onSignOut;

  OtherDetailsSection({required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSizeTitle = constraints.maxWidth * 0.05;
        double fontSizeItem = constraints.maxWidth * 0.04;

        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors1.weatherContainerColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Other Details",
                style: TextStyle(
                    color: AppColors1.textWhite, fontSize: fontSizeTitle),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.info, color: AppColors1.textWhite),
                title: Text(
                  "About",
                  style: TextStyle(
                      color: AppColors1.textWhite, fontSize: fontSizeItem),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: AppColors1.textWhite),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: AppColors1.textWhite),
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(
                      color: AppColors1.textWhite, fontSize: fontSizeItem),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: AppColors1.textWhite),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.logout, color: AppColors1.textWhite),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                      color: AppColors1.textWhite, fontSize: fontSizeItem),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: AppColors1.textWhite),
                onTap: () => onSignOut(),
              ),
            ],
          ),
        );
      },
    );
  }
}
