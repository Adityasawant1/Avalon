import 'package:avalon/Services/air_pollution_service.dart';
import 'package:flutter/material.dart';

class AirQualityPage extends StatefulWidget {
  @override
  _AirQualityPageState createState() => _AirQualityPageState();
}

class _AirQualityPageState extends State<AirQualityPage> {
  final AirQualityService _airQualityService = AirQualityService();
  Map<String, dynamic>? airQualityData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAirQuality();
  }

  Future<void> _fetchAirQuality() async {
    try {
      final data = await _airQualityService.fetchAirQuality(
          37.7749, -122.4194); // Example coordinates
      setState(() {
        airQualityData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching air quality data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air Quality'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : airQualityData != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Air Quality Index: ${airQualityData!['aqi']}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text('PM2.5: ${airQualityData!['pm25']} µg/m³'),
                      Text('PM10: ${airQualityData!['pm10']} µg/m³'),
                      Text('CO: ${airQualityData!['co']} µg/m³'),
                      Text('NO2: ${airQualityData!['no2']} µg/m³'),
                      Text('O3: ${airQualityData!['o3']} µg/m³'),
                      Text('SO2: ${airQualityData!['so2']} µg/m³'),
                    ],
                  ),
                )
              : Center(child: Text('No data available')),
    );
  }
}
