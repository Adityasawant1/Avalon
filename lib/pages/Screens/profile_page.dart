import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFF1B1E44);
  static const Color cardBackgroundColor = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFF1DA1F2);
  static const Color textWhite = Colors.white;
  static const Color textBlack = Colors.black;
  static const Color iconColor = Colors.white;
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: AppColors.iconColor),
        actions: [
          Icon(Icons.menu, color: AppColors.iconColor),
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
                'Travelers',
                style: TextStyle(color: AppColors.textWhite, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'I make videos. Lots of videos',
                style: TextStyle(color: AppColors.textWhite, fontSize: 14),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity, // Use double.infinity for full width
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Augustine William',
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star,
                            color: AppColors.buttonColor, size: 16),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '1M',
                              style: TextStyle(
                                color: AppColors.textBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                color: AppColors.textBlack,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '8',
                              style: TextStyle(
                                color: AppColors.textBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                color: AppColors.textBlack,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'MESSAGE',
                            style: TextStyle(
                              color: AppColors.textBlack,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.textBlack),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'FOLLOW',
                            style: TextStyle(
                              color: AppColors.textWhite,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Add demo posts using ListTile
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
}
