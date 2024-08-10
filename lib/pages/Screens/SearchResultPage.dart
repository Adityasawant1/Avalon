import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:avalon/utils/NGO_Reg_Model.dart';

class SearchResultPage extends StatefulWidget {
  final String query;

  SearchResultPage({required this.query});

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List<NGO> _searchResults = [];

  @override
  void initState() {
    super.initState();
    searchNGOs(widget.query);
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
      _searchResults = ngos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: _searchResults.isEmpty
          ? Center(
              child: Text(
                'No results found for "${widget.query}"',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final ngo = _searchResults[index];
                return ListTile(
                  title: Text(ngo.organizationName),
                  subtitle: Text('${ngo.category} • ${ngo.location}'),
                  onTap: () {
                    // Implement navigation to NGO detail page if required
                  },
                );
              },
            ),
    );
  }
}
