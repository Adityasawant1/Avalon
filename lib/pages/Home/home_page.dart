import 'package:avalon/pages/Screens/community.dart';
import 'package:avalon/theme/inside_color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// Import the colors

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors1.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors1.backgroundColor,
              floating: true,
              pinned: false,
              snap: true,
              elevation: 0,
              title: Center(
                child: Image.asset("assets/images/avalon.png",
                    width: size.width * 0.4, height: size.height * 0.5),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: AppColors1.avatarBackgroundColor,
                    child: Icon(Icons.person, color: AppColors1.textWhite),
                  ),
                )
              ],
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors1.avatarBackgroundColor,
                  child: Icon(Icons.grid_view_rounded,
                      color: AppColors1.textWhite),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors1.backgroundColor,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ExploreTab(
                              text: 'Home',
                              isSelected: true,
                              nextPage: HomePage(),
                            ),
                            ExploreTab(
                                text: 'Community',
                                isSelected: false,
                                nextPage: ProjectListScreen()),
                            // ExploreTab(
                            //     text: 'Task',
                            //     isSelected: false,
                            //     nextPage: HomePage()),
                            // ExploreTab(
                            //     text: 'News',
                            //     isSelected: false,
                            //     nextPage: HomePage()),
                            // ExploreTab(
                            //     text: 'Updates',
                            //     isSelected: false,
                            //     nextPage: HomePage()),
                            // ExploreTab(
                            //     text: 'Events',
                            //     isSelected: false,
                            //     nextPage: HomePage()),
                            // Add more tabs as needed
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    WeatherWidget(),
                    SizedBox(height: 20),
                    EnergyWidget(),
                    SizedBox(height: 20),
                    DevicesWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSizeTitle = constraints.maxWidth * 0.06;
        double fontSizeSubtitle = constraints.maxWidth * 0.04;
        double fontSizeTemperature = constraints.maxWidth * 0.12;
        double fontSizeFeelsLike = constraints.maxWidth * 0.04;

        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors1.weatherContainerColor,
            borderRadius: BorderRadius.circular(20),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Lottie.asset(
                    "assets/images/anime1.json",
                    height: constraints.maxWidth * 0.4,
                    width: constraints.maxWidth * 0.4,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Heavy Rain",
                        style: TextStyle(
                            color: AppColors1.textWhite,
                            fontSize: fontSizeTitle),
                      ),
                      Text(
                        "Tonight",
                        style: TextStyle(
                            color: AppColors1.textWhite,
                            fontSize: fontSizeSubtitle),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "27°",
                        style: TextStyle(
                            color: AppColors1.textWhite,
                            fontSize: fontSizeTemperature),
                      ),
                      Text(
                        "Feels like 32°",
                        style: TextStyle(
                            color: AppColors1.textWhite,
                            fontSize: fontSizeFeelsLike),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildStatBox("Humidity", "82%", constraints.maxWidth),
                    SizedBox(width: 10),
                    _buildStatBox("Wind", "15 km/h", constraints.maxWidth),
                    SizedBox(width: 10),
                    _buildStatBox("UV Index", "5", constraints.maxWidth),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatBox(String label, String value, double maxWidth) {
    double fontSizeLabel = maxWidth * 0.04;
    double fontSizeValue = maxWidth * 0.05;

    return Container(
      width: maxWidth * 0.25,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors1.avatarBackgroundColor,
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
      child: Column(
        children: [
          Text(
            label,
            style:
                TextStyle(color: AppColors1.textWhite, fontSize: fontSizeLabel),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style:
                TextStyle(color: AppColors1.textWhite, fontSize: fontSizeValue),
          ),
        ],
      ),
    );
  }
}

class EnergyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSizeTitle = constraints.maxWidth * 0.06;
        double fontSizeValue = constraints.maxWidth * 0.12;
        double fontSizeSubtitle = constraints.maxWidth * 0.04;

        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors1.weatherContainerColor,
            borderRadius: BorderRadius.circular(20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Energy",
                style: TextStyle(
                    color: AppColors1.textWhite, fontSize: fontSizeTitle),
              ),
              SizedBox(height: 10),
              Text(
                "16.4 kWh",
                style: TextStyle(
                    color: AppColors1.textWhite, fontSize: fontSizeValue),
              ),
              SizedBox(height: 10),
              Text(
                "3 Devices Turned On",
                style: TextStyle(
                    color: AppColors1.textWhite, fontSize: fontSizeSubtitle),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DevicesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: constraints.maxWidth < 600 ? 2 : 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            DeviceTile(
                deviceName: "Light",
                deviceCount: 23,
                maxWidth: constraints.maxWidth),
            DeviceTile(
                deviceName: "AC",
                deviceCount: 16,
                maxWidth: constraints.maxWidth),
            DeviceTile(
                deviceName: "Climate",
                deviceCount: 4,
                maxWidth: constraints.maxWidth),
          ],
        );
      },
    );
  }
}

class DeviceTile extends StatelessWidget {
  final String deviceName;
  final int deviceCount;
  final double maxWidth;

  DeviceTile(
      {required this.deviceName,
      required this.deviceCount,
      required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    double fontSizeTitle = maxWidth * 0.06;
    double fontSizeSubtitle = maxWidth * 0.04;

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors1.deviceContainerColor,
        borderRadius: BorderRadius.circular(20),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            deviceName,
            style:
                TextStyle(color: AppColors1.textWhite, fontSize: fontSizeTitle),
          ),
          SizedBox(height: 10),
          Text(
            "$deviceCount Devices",
            style: TextStyle(
                color: AppColors1.textWhite, fontSize: fontSizeSubtitle),
          ),
        ],
      ),
    );
  }
}

class ExploreTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Widget
      nextPage; // Add this property to specify the next page to navigate to

  ExploreTab(
      {required this.text, required this.isSelected, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors1.exploreTabSelectedColor
                : AppColors1.exploreTabUnselectedColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? AppColors1.textBlack : AppColors1.textWhite,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
