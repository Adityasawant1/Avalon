import 'dart:convert';
import 'package:http/http.dart' as http;

class AirQualityService {
  final String apiKey = 'AIzaSyAtHac4xrOZk7PlEp7TZwPoJ58Rj9LD1Fg';

  Future<Map<String, dynamic>> fetchAirQuality(double lat, double lon) async {
    final url = Uri.parse(
      'https://www.googleapis.com/geolocation/v1/geolocate?key=$apiKey',
    );

    final response = await http.post(url,
        body: jsonEncode({'latitude': lat, 'longitude': lon}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load air quality data');
    }
  }
}
