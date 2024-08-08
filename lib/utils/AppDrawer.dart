import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      //slide from left side
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green[200],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.12,
                  backgroundImage: AssetImage('assets/images/e1.png'),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Welcome to Avalon',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: ListTile(
              leading: Icon(Icons.person, size: screenWidth * 0.07),
              title: Text('Profile',
                  style: TextStyle(fontSize: screenWidth * 0.045)),
              onTap: () {
                // Add navigation logic here for Profile
                Navigator.pop(context);
              },
            ),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: ListTile(
              leading: Icon(Icons.leaderboard, size: screenWidth * 0.07),
              title: Text('LeaderBoard',
                  style: TextStyle(fontSize: screenWidth * 0.045)),
              onTap: () {
                // Add navigation logic here for LeaderBoard
                Navigator.pop(context);
              },
            ),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: ListTile(
              leading: Icon(Icons.group_add, size: screenWidth * 0.07),
              title: Text('Invite Friend',
                  style: TextStyle(fontSize: screenWidth * 0.045)),
              onTap: () {
                // Add navigation logic here for About
                Navigator.pop(context);
              },
            ),
          ),

          SizedBox(
            height: screenWidth * 0.4,
          ), // Adds a divider between main items and bottom items
          Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SlideTransition(
                position: _offsetAnimation,
                child: ListTile(
                  leading: Icon(Icons.info, size: screenWidth * 0.07),
                  title: Text('About',
                      style: TextStyle(fontSize: screenWidth * 0.045)),
                  onTap: () {
                    // Add navigation logic here for Invite Friend
                    Navigator.pop(context);
                  },
                ),
              ),
              SlideTransition(
                position: _offsetAnimation,
                child: ListTile(
                  leading: Icon(Icons.settings, size: screenWidth * 0.07),
                  title: Text('Settings',
                      style: TextStyle(fontSize: screenWidth * 0.045)),
                  onTap: () {
                    // Add navigation logic here for Settings
                    Navigator.pop(context);
                  },
                ),
              ),
              SlideTransition(
                position: _offsetAnimation,
                child: ListTile(
                  leading: Icon(Icons.logout, size: screenWidth * 0.07),
                  title: Text('Logout',
                      style: TextStyle(fontSize: screenWidth * 0.045)),
                  onTap: () {
                    // Add logout logic here
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
