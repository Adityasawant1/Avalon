import 'package:avalon/utils/AppDrawer.dart';
import 'package:flutter/material.dart';
import 'package:avalon/pages/Screens/community.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: AppDrawer(), // Use the AppDrawer here
      appBar: AppBar(
        title: Center(
          child: Text(
            'A V A L O N',
            style: TextStyle(
              fontSize: screenWidth * 0.08, // Responsive font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/e1.png'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Which NGOs \nyou want to search?',
              style: TextStyle(
                fontSize: screenWidth * 0.06, // Responsive font size
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive spacing
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Explore Nature',
              style: TextStyle(
                fontSize: screenWidth * 0.05, // Responsive font size
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilterChip(label: Text('All'), onSelected: (selected) {}),
                  const SizedBox(width: 10),
                  FilterChip(label: Text('Popular'), onSelected: (selected) {}),
                  const SizedBox(width: 10),
                  FilterChip(
                    label: Text("Community"),
                    onSelected: (selected) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectListScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02), // Responsive margin
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: screenWidth * 0.08, // Responsive radius
            child: Icon(icon, size: screenWidth * 0.07), // Responsive icon size
          ),
          SizedBox(height: screenWidth * 0.01), // Responsive spacing
          Text(label),
        ],
      ),
    );
  }
}

class CityCard extends StatelessWidget {
  final String image;
  final String city;
  final String place;

  CityCard({required this.image, required this.city, required this.place});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  city,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035, // Responsive font size
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
