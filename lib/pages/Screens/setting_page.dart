import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            AccountSection(),
            SizedBox(height: 20),
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
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[700],
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'David Clerisseau',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Personal Info',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white),
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
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.language, color: Colors.orange),
            title: Text('Language', style: TextStyle(color: Colors.white)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('English', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward_ios, color: Colors.white),
              ],
            ),
            onTap: () {},
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue),
            title: Text('Notifications', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {},
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.dark_mode, color: Colors.purple),
            title: Text('Dark Mode', style: TextStyle(color: Colors.white)),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
              activeColor: Colors.purple,
            ),
            onTap: () {},
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.help, color: Colors.red),
            title: Text('Help', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
