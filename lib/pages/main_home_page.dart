import 'package:avalon/pages/home_page.dart';
import 'package:avalon/pages/profile_page.dart';
import 'package:avalon/pages/setting_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Color(0xFF1C1C1E),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        color: Colors.grey.shade800,
        onTap: (index) {
          _onItemTapped(index);
        },
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.explore, color: Colors.white),
          Icon(Icons.add, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {});
        },
        children: [
          HomePage(),
          HomePage(), // Replace with your Explore page
          HomePage(), // Replace with your Add page
          ProfilePage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
