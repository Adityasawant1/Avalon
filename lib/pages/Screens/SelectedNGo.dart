import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:avalon/utils/NGO_Reg_Model.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFF1B1E44);
  static const Color cardBackgroundColor = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFF1DA1F2);
  static const Color textWhite = Colors.white;
  static const Color textBlack = Colors.black;
  static const Color iconColor = Colors.white;
}

class NGOListPage extends StatelessWidget {
  final NGO ngo;

  NGOListPage({required this.ngo});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade500,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade500,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/e1.png'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
              ),
              Text(
                ngo.organizationName,
                style: TextStyle(color: AppColors.textWhite, fontSize: 18),
              ),
              SizedBox(height: 8),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueGrey.shade100,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NGO Name and Rating
                    Row(
                      children: [
                        Text(
                          ngo.organizationName,
                          style: TextStyle(
                            color: AppColors.textBlack,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: AppColors.buttonColor, size: 20),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // About Section
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        ngo.organizationBio,
                        style: const TextStyle(
                          color: AppColors.textBlack,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Details Section
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackgroundColor,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Details',
                            style: TextStyle(
                              color: AppColors.textBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          _buildDetailItem('Category', ngo.category),
                          _buildDetailItem('Country', ngo.country),
                          _buildDetailItem('Location', ngo.location),
                          GestureDetector(
                            onTap: () => _launchURL(ngo.website),
                            child: _buildDetailItem('Website', ngo.website,
                                color: AppColors.buttonColor),
                          ),
                          _buildDetailItem('Contact', ngo.contactDetails),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Edit Profile Button
                    if (ngo.ownerId == currentUser?.uid)
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to a page where the owner can edit the NGO details
                        },
                        child: Text(
                          'EDIT PROFILE',
                          style: TextStyle(color: AppColors.textWhite),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor,
                        ),
                      ),
                    SizedBox(height: 16),
                    // Demo Posts Section
                    Column(
                      children: List.generate(5, (index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackgroundColor,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                            ),
                            title: Text(
                              'Post Title $index',
                              style: TextStyle(color: AppColors.textBlack),
                            ),
                            subtitle: Text(
                              'This is a description of post $index.',
                              style: TextStyle(color: AppColors.textBlack),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value,
      {Color color = AppColors.textBlack}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}
