// campaign_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Campaign {
  final String name;
  final String description;
  final String imageURL;
  final String ngoName;

  Campaign({
    required this.name,
    required this.description,
    required this.imageURL,
    required this.ngoName,
  });

  factory Campaign.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Campaign(
      name: data['name'] ?? 'Unknown',
      description: data['description'] ?? 'No description available',
      imageURL: data['imageURL'] ?? 'https://via.placeholder.com/150',
      ngoName: data['ngoName'] ?? 'Unknown',
    );
  }
}
