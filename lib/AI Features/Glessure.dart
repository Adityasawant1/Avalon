import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GlessurePage extends StatefulWidget {
  @override
  _GlessurePageState createState() => _GlessurePageState();
}

class _GlessurePageState extends State<GlessurePage> {
  bool _showNote = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Glessure Information',
          style: GoogleFonts.roboto(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_showNote)
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Note:',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'A comprehensive index for Glessure will be added soon with scrollable text.',
                            style: GoogleFonts.roboto(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _showNote = false;
                              });
                            },
                            child: Text(
                              'Dismiss',
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overview',
                          style: GoogleFonts.roboto(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Glessure refers to a hypothetical concept or term, which could involve a detailed explanation, effects, and potential solutions related to it. Since this is a placeholder, this section would explain what Glessure is and its significance.',
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How to Address Glessure',
                          style: GoogleFonts.roboto(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '1. Step one to address Glessure: Explanation of the first step.\n\n'
                          '2. Step two to address Glessure: Explanation of the second step.\n\n'
                          '3. Step three to address Glessure: Explanation of the third step.\n\n'
                          '4. Step four to address Glessure: Explanation of the fourth step.',
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amberAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Additional Information',
                          style: GoogleFonts.roboto(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        FutureBuilder<String>(
                          future: fetchGlessureData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error fetching data'));
                            } else {
                              return Text(
                                snapshot.data ?? '',
                                style: GoogleFonts.roboto(fontSize: 16),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      child: Text(
                        'Glessure Index: Coming Soon',
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  SizedBox(height: 32), // Added more spacing at the bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> fetchGlessureData() async {
    final apiKey =
        'AIzaSyBAT7lXd2P5yGn5fwBV6YPUYru1gdWbRPk'; // Replace with your actual API key
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final content = [
      Content.text(
          'Provide detailed information on Glessure and its effects worldwide.')
    ];
    final response = await model.generateContent(content);
    return response.text ??
        'No additional information available at this time.'; // Ensure a String is always returned
  }
}
