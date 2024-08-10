// services/gemini_ai_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiAIService {
  final String _baseUrl =
      'https://api.gemini.ai/explain'; // Replace with actual URL
  final String _apiKey = 'AIzaSyBnYrvIj1JVFmp2V8blLdM_OvJLsJn3a-0';

  Future<String> fetchExplanation(String data) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({'data': data}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = json.decode(response.body);
      return result['explanation'];
    } else {
      throw Exception('Failed to load explanation');
    }
  }
}
