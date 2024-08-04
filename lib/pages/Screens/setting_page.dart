import 'package:avalon/pages/Screens/RegisterNGOPage.dart';
import 'package:avalon/pages/Screens/change_pass.dart';
import 'package:avalon/pages/Screens/help_Page.dart';
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

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors1.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors1.backgroundColor,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(color: AppColors1.textWhite, fontSize: 24),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors1.textWhite),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            AccountSection(),
            const SizedBox(height: 20),
            SettingsSection(),
          ],
        ),
      ),
    );
  }
}

class AccountSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors1.weatherContainerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              'assets/images/settingprofile.png',
            ), // Replace with your image asset
            backgroundColor: AppColors1.avatarBackgroundColor,
          ),
          const SizedBox(height: 10),
          const Text(
            ' Aditya is here',
            style: TextStyle(color: AppColors1.textWhite, fontSize: 18),
          ),
          const Text(
            'rima.ayed26@gmail.com',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors1.avatarBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Edit',
                style: TextStyle(color: AppColors1.textWhite)),
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors1.weatherContainerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.orange),
            title: const Text('Register your NGO',
                style: TextStyle(color: AppColors1.textWhite)),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: AppColors1.textWhite),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterNGOPage()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.green),
            title: const Text('Change Password',
                style: TextStyle(color: AppColors1.textWhite)),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: AppColors1.textWhite),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.dark_mode, color: Colors.purple),
            title: const Text('Dark Mode',
                style: TextStyle(color: AppColors1.textWhite)),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
              activeColor: Colors.purple,
            ),
            onTap: () {},
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.red),
            title: const Text('Help',
                style: TextStyle(color: AppColors1.textWhite)),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: AppColors1.textWhite),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPage()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout',
                style: TextStyle(color: AppColors1.textWhite)),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: AppColors1.textWhite),
            onTap: () {
              _signOut();
            },
          ),
        ],
      ),
    );
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }
}
