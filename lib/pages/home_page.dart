import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFF1C1C1E),
              floating: true,
              pinned: false,
              snap: true,
              elevation: 0,
              title: Center(
                child: Text(
                  "Avalon",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                )
              ],
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Icon(Icons.grid_view_rounded),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        color: Colors.grey.shade800,
        onTap: (index) {
          _onItemTapped(index);
        },
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
          Icon(Icons.add, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
          Icon(Icons.settings, color: Colors.white)
        ],
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
            color: Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/earth.png',
                      height: constraints.maxWidth * 0.4,
                      width: constraints.maxWidth * 0.4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Heavy Rain",
                        style: TextStyle(
                            color: Colors.white, fontSize: fontSizeTitle),
                      ),
                      Text(
                        "Tonight",
                        style: TextStyle(
                            color: Colors.white, fontSize: fontSizeSubtitle),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "27°",
                        style: TextStyle(
                            color: Colors.white, fontSize: fontSizeTemperature),
                      ),
                      Text(
                        "Feels like 32°",
                        style: TextStyle(
                            color: Colors.white, fontSize: fontSizeFeelsLike),
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
        color: Color(0xFF3A3A3C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: fontSizeLabel),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: fontSizeValue),
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
            color: Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Energy",
                style: TextStyle(color: Colors.white, fontSize: fontSizeTitle),
              ),
              SizedBox(height: 10),
              Text(
                "16.4 kWh",
                style: TextStyle(color: Colors.white, fontSize: fontSizeValue),
              ),
              SizedBox(height: 10),
              Text(
                "3 Devices Turn On",
                style:
                    TextStyle(color: Colors.white, fontSize: fontSizeSubtitle),
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
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            deviceName,
            style: TextStyle(color: Colors.white, fontSize: fontSizeTitle),
          ),
          Spacer(),
          Text(
            "$deviceCount Devices",
            style: TextStyle(color: Colors.white, fontSize: fontSizeSubtitle),
          ),
        ],
      ),
    );
  }
}
