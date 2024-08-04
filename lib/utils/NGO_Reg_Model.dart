class NGO {
  final String organizationName;
  final String organizationBio;
  final String category;
  final String country;
  final String location;
  final String website;
  final String contactDetails;

  NGO({
    required this.organizationName,
    required this.organizationBio,
    required this.category,
    required this.country,
    required this.location,
    required this.website,
    required this.contactDetails,
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
    };
  }
}
