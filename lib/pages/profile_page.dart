import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFF1C1C1E),
              floating: true,
              pinned: false,
              snap: true,
              elevation: 0,
              title: Center(
                child: Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Icon(Icons.edit),
                  ),
                )
              ],
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInfoSection(),
                    SizedBox(height: 20),
                    AccountSettingsSection(),
                    SizedBox(height: 20),
                    OtherDetailsSection(),
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
            color: Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage: AssetImage('assets/images/earth.png'),
              ),
              SizedBox(height: 10),
              Text(
                "John Doe",
                style: TextStyle(color: Colors.white, fontSize: fontSizeName),
              ),
              SizedBox(height: 5),
              Text(
                "johndoe@example.com",
                style: TextStyle(color: Colors.white, fontSize: fontSizeEmail),
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
        double fontSizeTitle = constraints.maxWidth * 0.06;
        double fontSizeItem = constraints.maxWidth * 0.04;

        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Settings",
                style: TextStyle(color: Colors.white, fontSize: fontSizeTitle),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.white),
                title: Text(
                  "Change Password",
                  style: TextStyle(color: Colors.white, fontSize: fontSizeItem),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.email, color: Colors.white),
                title: Text(
                  "Update Email",
                  style: TextStyle(color: Colors.white, fontSize: fontSizeItem),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.white),
                title: Text(
                  "Update Phone Number",
                  style: TextStyle(color: Colors.white, fontSize: fontSizeItem),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
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
  // Fun to Logout from app

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSizeTitle = constraints.maxWidth * 0.06;
        double fontSizeItem = constraints.maxWidth * 0.04;

        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Other Details",
                style: TextStyle(color: Colors.white, fontSize: fontSizeTitle),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text(
                  "About",
                  style: TextStyle(color: Colors.white, fontSize: fontSizeItem),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.help, color: Colors.white),
                title: Text(
                  "Help & Support",
                  style: TextStyle(color: Colors.white, fontSize: fontSizeItem),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                title: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: fontSizeItem),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                onTap: () {
                  signOut();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
