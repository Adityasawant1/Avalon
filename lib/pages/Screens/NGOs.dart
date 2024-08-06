import 'package:avalon/utils/NGO_Reg_Model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:avalon/theme/inside_color.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              // Show a message or handle the scenario where the page cannot be popped
              // For example, navigate to a default page or show a Snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No previous page to go back to!')),
              );
            }
          },
        ),
        title: Center(
          child: Text(
            'N G O',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20, // Adjust font size if needed
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('ngos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No NGOs registered yet.',
                style: TextStyle(color: AppColors1.textWhite),
              ),
            );
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
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/e3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // NGO Name
                      Center(
                        child: Text(
                          ngo.organizationName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // NGO Category
                      Text(
                        ngo.category,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      // NGO Bio
                      Text(
                        ngo.organizationBio,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3),
                      // Website
                      GestureDetector(
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
              );
            },
          );
        },
      ),
    );
  }
}
