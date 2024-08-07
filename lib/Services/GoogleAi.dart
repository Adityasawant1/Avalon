import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Googleai extends StatefulWidget {
  const Googleai({super.key});

  @override
  State<Googleai> createState() => _GoogleaiState();
}

class _GoogleaiState extends State<Googleai> {
  String _generatedText = '';

  // Define a constant to hold your API key
  static const String _apiKey =
      "AIzaSyBnYrvIj1JVFmp2V8blLdM_OvJLsJn3a-0"; // Replace this placeholder

  Future<void> generateStory() async {
    // Create the model with your API key
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);
    final content = [Content.text((InputA.text))];
    try {
      final response = await model.generateContent(content);
      setState(() {
        _generatedText = response.text!;
      });
    } catch (e) {
      print('Failed to generate content: $e');
    }
  }

  final InputA = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google AI Content Generator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  generateStory();
                  _generatedText = "";
                }, // Use the corrected method name
                child: const Text('Generate Story'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _generatedText = "";
                  });
                }, // Use the corrected method name
                child: const Text('Clear Generated Text'),
              ),
              TextField(
                controller: InputA,
              ),
              const SizedBox(height: 20),
              if (_generatedText.isNotEmpty)
                Text(
                  'Generated Text:\n$_generatedText',
                  style: const TextStyle(fontSize: 16.0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
