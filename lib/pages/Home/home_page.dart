import 'package:avalon/utils/AppDrawer.dart';
import 'package:avalon/utils/HomeCarousel.dart';
import 'package:flutter/material.dart';
import 'package:avalon/pages/Screens/community.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blueGrey.shade100,
            floating: true,
            pinned: false,
            snap: true,
            title: Center(
              child: Text(
                'A V A L O N',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blueGrey.shade100,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlideTransition(
                          position: _slideAnimation,
                          child: Text(
                            'Which NGOs \nyou want to search?',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        SlideTransition(
                          position: _slideAnimation,
                          child: TextFormField(
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
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        SlideTransition(
                          position: _slideAnimation,
                          child: Container(
                            height: 193,
                            width: screenWidth,
                            child: HomeCarousel(),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        SlideTransition(
                          position: _slideAnimation,
                          child: Text(
                            'Explore Nature',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FilterChip(
                                    label: Text('All'),
                                    onSelected: (selected) {}),
                                const SizedBox(width: 10),
                                FilterChip(
                                    label: Text('Popular'),
                                    onSelected: (selected) {}),
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
                        ),
                      ],
                    ),
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

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: screenWidth * 0.08,
            child: Icon(icon, size: screenWidth * 0.07),
          ),
          SizedBox(height: screenWidth * 0.01),
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
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  city,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
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
