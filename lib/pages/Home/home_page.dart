import 'package:avalon/pages/Screens/SearchResultPage.dart';
import 'package:avalon/utils/AppDrawer.dart';
import 'package:avalon/utils/HomeCarousel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:avalon/pages/Screens/community.dart';
import 'package:avalon/utils/NGO_Reg_Model.dart';

//looks like this
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _searchController = TextEditingController();
  List<NGO> _ngoSuggestions = [];

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

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _ngoSuggestions = [];
      });
    } else {
      searchNGOs(_searchController.text);
    }
  }

  Future<void> searchNGOs(String query) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('ngos')
        .where('organizationName', isGreaterThanOrEqualTo: query)
        .where('organizationName', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    final ngos = snapshot.docs.map((doc) {
      return NGO(
        organizationName: doc['organizationName'],
        organizationBio: doc['organizationBio'],
        category: doc['category'],
        country: doc['country'],
        location: doc['location'],
        website: doc['website'],
        contactDetails: doc['contactDetails'],
      );
    }).toList();

    setState(() {
      _ngoSuggestions = ngos;
    });
  }

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultPage(query: query),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: AppDrawer(
        user: FirebaseAuth.instance.currentUser,
      ),
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
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _searchController,
                                onFieldSubmitted: _onSearchSubmitted,
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
                              SizedBox(height: screenHeight * 0.01),
                              if (_ngoSuggestions.isNotEmpty)
                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: _ngoSuggestions.length,
                                    itemBuilder: (context, index) {
                                      final ngo = _ngoSuggestions[index];
                                      return ListTile(
                                        title: Text(ngo.organizationName),
                                        subtitle: Text(ngo.category),
                                        onTap: () {
                                          _onSearchSubmitted(
                                              ngo.organizationName);
                                        },
                                      );
                                    },
                                  ),
                                ),
                            ],
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
                                  label: Text("Campaign"),
                                  onSelected: (selected) {
                                    // No need to push to ProjectListScreen,
                                    // We'll display the campaigns directly on the homepage
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Display campaigns below the "Campaign" button
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('campaigns')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            final campaigns = snapshot.data?.docs;

                            if (campaigns == null || campaigns.isEmpty) {
                              return Center(child: Text('No campaigns found.'));
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: campaigns.length,
                              itemBuilder: (context, index) {
                                var campaign = campaigns[index].data()
                                    as Map<String, dynamic>;

                                return ProjectCard(
                                  name: campaign['name'] ?? 'Unknown',
                                  description: campaign['description'] ??
                                      'No description available',
                                  imagePath: campaign['imageURL'] ??
                                      'https://via.placeholder.com/150',
                                  ngoName: campaign['ngoName'] ?? 'Unknown',
                                );
                              },
                            );
                          },
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
