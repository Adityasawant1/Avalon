import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class PlantScannerPage extends StatefulWidget {
  const PlantScannerPage({Key? key}) : super(key: key);

  @override
  State<PlantScannerPage> createState() => _PlantScannerPageState();
}

class _PlantScannerPageState extends State<PlantScannerPage> {
  File? _selectedImage;
  String? _plantInformation;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      _analyzeImage();
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Replace this with your actual API key
    final apiKey =
        'AIzaSyBnYrvIj1JVFmp2V8blLdM_OvJLsJn3a-0'; // <--- Add your actual API key here

    // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final imageBytes = await _selectedImage!.readAsBytes();

    // Customize the text prompt for plant identification
    final prompt = TextPart(
        "Identify this plant and provide information about its characteristics, care requirements, and any interesting facts.");
    final imagePart = DataPart('image/jpeg', imageBytes);

    final response = await model.generateContent([
      Content.multi([prompt, imagePart])
    ]);

    setState(() {
      _plantInformation = response.text;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Avalon Plant',
            style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: Colors.black, // Black AppBar
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_selectedImage != null)
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blueGrey.shade100,
                          Colors.white,
                        ],
                      ),
                      border: Border.all(color: Colors.white), // Green border
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(_selectedImage!, fit: BoxFit.cover),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getImageFromGallery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Black button
                    padding: const EdgeInsets.symmetric(
                        horizontal: 41, vertical: 18),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  child: const Text('SELECT IMAGE'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Black button
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 18),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  child: const Text('GO BACK'),
                ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator(
                    color: Colors.green, // Green loading indicator
                  ),
                if (_plantInformation != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      color: Colors.white, // White background
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        _plantInformation!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
