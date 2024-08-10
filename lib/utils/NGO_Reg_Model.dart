// lib/utils/NGO_Reg_Model.dart

class NGO {
  final String organizationName;
  final String organizationBio;
  final String category;
  final String country;
  final String location;
  final String website;
  final String contactDetails;
  final String? ownerId; // Optional field for the owner's user ID

  NGO({
    required this.organizationName,
    required this.organizationBio,
    required this.category,
    required this.country,
    required this.location,
    required this.website,
    required this.contactDetails,
    this.ownerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'organizationName': organizationName,
      'organizationBio': organizationBio,
      'category': category,
      'country': country,
      'location': location,
      'website': website,
      'contactDetails': contactDetails,
      'ownerId': ownerId, // Include the ownerId in the map
    };
  }

  // Optional: A method to create an NGO instance from a map
  factory NGO.fromMap(Map<String, dynamic> map) {
    return NGO(
      organizationName: map['organizationName'] ?? '',
      organizationBio: map['organizationBio'] ?? '',
      category: map['category'] ?? '',
      country: map['country'] ?? '',
      location: map['location'] ?? '',
      website: map['website'] ?? '',
      contactDetails: map['contactDetails'] ?? '',
      ownerId: map['ownerId'],
    );
  }
}
