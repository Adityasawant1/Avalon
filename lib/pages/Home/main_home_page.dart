import 'package:avalon/pages/Home/home_page.dart';
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
      // appBar: AppBar(
      //   backgroundColor: AppColors2.backgroundColor,
      //   elevation: 0,
      //   title: Center(
      //     child: Image.asset("assets/images/avalon.png",
      //         width: size.width * 0.4, height: size.height * 0.5),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: CircleAvatar(
      //         backgroundColor: AppColors2.avatarBackgroundColor,
      //         child: Icon(Icons.person, color: AppColors2.textWhite),
      //       ),
      //     )
      //   ],
      //   leading: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: CircleAvatar(
      //       backgroundColor: AppColors2.avatarBackgroundColor,
      //       child: Icon(Icons.grid_view_rounded, color: AppColors2.textWhite),
      //     ),
      //   ),
      // ),
      backgroundColor: Color.fromARGB(255, 46, 92, 83),
      bottomNavigationBar: GNav(
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          tabMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          backgroundColor: Colors.transparent,
          // tab button border
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 500),
          gap: 5,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Color.fromARGB(255, 64, 128, 114),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.people_alt_rounded,
              text: "NGO",
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
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
