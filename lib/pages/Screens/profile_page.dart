import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors1.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
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
                    child: Icon(Icons.edit, color: AppColors1.textWhite),
                  ),
                )
              ],
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors1.avatarBackgroundColor,
                  child: Icon(Icons.arrow_back, color: AppColors1.textWhite),
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
                    Center(child: UserInfoSection()),
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
            color: AppColors1.weatherContainerColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              SizedBox(height: 10),
              Text(
                "Aditya",
                style: TextStyle(
                    color: AppColors1.textWhite, fontSize: fontSizeName),
              ),
              SizedBox(height: 5),
              Text(
                "johndoe@example.com",
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
        double fontSizeTitle = constraints.maxWidth * 0.06;
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
                  "Update Email",
                  style: TextStyle(
                      color: AppColors1.textWhite, fontSize: fontSizeItem),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: AppColors1.textWhite),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.phone, color: AppColors1.textWhite),
                title: Text(
                  "Update Phone Number",
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
                leading: Icon(Icons.help, color: AppColors1.textWhite),
                title: Text(
                  "Help & Support",
                  style: TextStyle(
                      color: AppColors1.textWhite, fontSize: fontSizeItem),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: AppColors1.textWhite),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: AppColors1.textWhite),
                title: Text(
                  "Logout",
                  style: TextStyle(
                      color: AppColors1.textWhite, fontSize: fontSizeItem),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: AppColors1.textWhite),
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
