import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectListScreen extends StatefulWidget {
  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('campaigns').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final campaigns = snapshot.data?.docs;

          if (campaigns == null || campaigns.isEmpty) {
            return Center(child: Text('No campaigns found.'));
          }

          return ListView.builder(
            itemCount: campaigns.length,
            itemBuilder: (context, index) {
              var campaign = campaigns[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Error handling for missing imageURL
                            if (campaign['imageURL'] != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  campaign['imageURL'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            SizedBox(height: 10),
                            // Error handling for missing name
                            if (campaign['name'] != null)
                              Text(
                                campaign['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            SizedBox(height: 5),
                            // Error handling for missing description
                            if (campaign['description'] != null)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  campaign['description'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            SizedBox(height: 5),
                            // Error handling for missing ngoName
                            if (campaign['ngoName'] != null)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Uploaded by: ${campaign['ngoName']}',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: ProjectCard(
                  name: campaign['name'] ?? 'Unknown', // Default name
                  description: campaign['description'] ??
                      'No description available', // Default description
                  imagePath: campaign['imageURL'] ??
                      'https://via.placeholder.com/150', // Default image
                  ngoName: campaign['ngoName'] ?? 'Unknown', // Default ngoName
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String name;
  final String description;
  final String imagePath;
  final String ngoName;

  ProjectCard({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.ngoName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        leading: Image.network(imagePath, width: 80, fit: BoxFit.cover),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            SizedBox(height: 4),
            Text('Uploaded by: $ngoName',
                style: TextStyle(color: Colors.blueGrey)),
          ],
        ),
      ),
    );
  }
}
