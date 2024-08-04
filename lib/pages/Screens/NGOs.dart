import 'package:avalon/pages/Screens/community.dart';
import 'package:avalon/utils/NGO_Reg_Model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class CollaborationPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to launch the URL in the default browser
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors2.backgroundColor, // Set app bar color
        title: Text('Collaboration'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('ngos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(
                child: Text('No NGOs registered yet.',
                    style: TextStyle(color: AppColors2.textWhite)));
          }

          final ngos = snapshot.data!.docs.map((doc) {
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

          return ListView.builder(
            itemCount: ngos.length,
            itemBuilder: (context, index) {
              final ngo = ngos[index];
              return Container(
                width: size.width * 0.9,
                height: size.height * 0.25,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors2.backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.35,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/images/NGO.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // NGO Name
                            Text(
                              ngo.organizationName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors2.textWhite,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2),
                            // NGO Category
                            Text(
                              ngo.category,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            // NGO Bio
                            Expanded(
                              child: Text(
                                ngo.organizationBio,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white54,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 3),
                            // Website
                            OverflowBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 2),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _launchURL(ngo.website),
                                    child: Text(
                                      ngo.website,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "${ngo.location}, ${ngo.country} ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
