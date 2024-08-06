import 'package:avalon/pages/Home/home_page.dart';
import 'package:avalon/pages/Screens/NGOs.dart';
import 'package:avalon/pages/Screens/profile_page.dart';
import 'package:avalon/pages/Screens/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: GNav(
          haptic: true, // haptic feedback
          tabBorderRadius: 25,
          tabMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          backgroundColor: Colors.transparent,
          // tab button border
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 500),
          gap: 5,
          color: Colors.black87,
          activeColor: Colors.green,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
            GButton(
              icon: Icons.people_alt_rounded,
              text: "NGO",
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ],
          selectedIndex: 0,
          onTabChange: (index) {
            _onItemTapped(index);
          }),
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          ProfilePage(),
          CollaborationPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}

class ConstAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
