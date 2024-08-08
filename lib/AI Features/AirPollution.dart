import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AirQualityScreen extends StatefulWidget {
  @override
  _AirQualityScreenState createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  List<AirQualityData> airQualityData = [];
  String selectedLocation = 'India'; // Default location

  @override
  void initState() {
    super.initState();
    fetchAirQualityData(selectedLocation);
  }

  Future<void> fetchAirQualityData(String location) async {
    // Replace with your actual Google Air Quality API key
    String apiKey = 'AIzaSyAtHac4xrOZk7PlEp7TZwPoJ58Rj9LD1Fg';

    // Modify this API call based on the actual Google Air Quality API endpoint
    String apiUrl =
        'https://www.googleapis.com/airquality/v1beta1/locations/$location/latestMeasurements?key=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          airQualityData = (data['measurements'] as List).map((measurement) {
            return AirQualityData(
              parameter: measurement['parameter'] as String,
              value: measurement['value'] as double,
              unit: measurement['unit'] as String,
            );
          }).toList();
        });
      } else {
        print('Failed to load air quality data.');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Air Quality'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location selection (add dropdown or other input methods)
              DropdownButton<String>(
                value: selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    selectedLocation = newValue!;
                    fetchAirQualityData(
                        selectedLocation); // Update data when location changes
                  });
                },
                items: ['Your Location', 'Location 1', 'Location 2']
                    .map((location) => DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        ))
                    .toList(),
              ),

              // Data Display (Line Chart)
              if (airQualityData.isNotEmpty)
                Container(
                  height: 300,
                  child: SfCartesianChart(
                    series: <CartesianSeries<AirQualityData, String>>[
                      LineSeries<AirQualityData, String>(
                        dataSource: airQualityData,
                        xValueMapper: (AirQualityData data, _) =>
                            data.parameter,
                        yValueMapper: (AirQualityData data, _) => data.value,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                )
              else
                const CircularProgressIndicator(),

              // Air Quality Info
              for (var data in airQualityData)
                ListTile(
                  title: Text(data.parameter),
                  trailing: Text('${data.value} ${data.unit}'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AirQualityData {
  final String parameter;
  final double value;
  final String unit;

  AirQualityData(
      {required this.parameter, required this.value, required this.unit});
}
