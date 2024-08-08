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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Scanner'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_selectedImage != null)
                Image.file(_selectedImage!, height: 200, width: 200),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getImageFromGallery,
                child: const Text('Select Image from Gallery'),
              ),
              const SizedBox(height: 20),
              if (_plantInformation != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _plantInformation!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
