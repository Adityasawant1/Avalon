import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryStateCityService {
  static const String _baseUrl = 'https://api.countrystatecity.in/v1';
  static const String _apiKey =
      'Sk80ZTJWMllCQjU1N1dDZjJ0emtPZGxiOTBTdXJDc0UzV0tYWWYybg=='; // Replace with your API key

  Future<List<dynamic>> fetchCountries() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/countries'),
      headers: {
        'X-CSCAPI-KEY': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<List<dynamic>> fetchStates(String countryCode) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/countries/$countryCode/states'),
      headers: {
        'X-CSCAPI-KEY': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load states');
    }
  }

  Future<List<dynamic>> fetchCities(
      String countryCode, String stateCode) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/countries/$countryCode/states/$stateCode/cities'),
      headers: {
        'X-CSCAPI-KEY': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load cities');
    }
  }
}
