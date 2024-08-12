import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class WaterPollutionPage extends StatefulWidget {
  @override
  _WaterPollutionPageState createState() => _WaterPollutionPageState();
}

class _WaterPollutionPageState extends State<WaterPollutionPage> {
  bool _showNote = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Water Pollution Information',
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
                            'A comprehensive index for water pollution will be added soon with scrollable text.',
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
                          'Water pollution is the contamination of water bodies, typically as a result of human activities. Pollutants are substances that make water unsuitable for drinking, swimming, cooking, and other uses.',
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
                          'How to Reduce Water Pollution',
                          style: GoogleFonts.roboto(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '1. Reduce the use of plastic: Plastic waste is one of the major contributors to water pollution. Avoid using single-use plastics and opt for reusable alternatives.\n\n'
                          '2. Proper disposal of chemicals: Avoid pouring chemicals, oils, and medications down the drain. Instead, dispose of them properly at designated disposal facilities.\n\n'
                          '3. Plant trees: Trees help prevent soil erosion, which reduces sediment runoff into water bodies. This helps maintain clean water sources.\n\n'
                          '4. Conserve water: Use water efficiently to reduce the amount of wastewater produced. Fix leaks and consider using water-saving fixtures.',
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
                          future: fetchWaterPollutionData(),
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
                        'Water Pollution Index: Coming Soon',
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

  Future<String> fetchWaterPollutionData() async {
    final apiKey =
        'AIzaSyBAT7lXd2P5yGn5fwBV6YPUYru1gdWbRPk'; // Replace with your actual API key
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final content = [
      Content.text(
          'Provide detailed information on water pollution and its effects worldwide.')
    ];
    final response = await model.generateContent(content);
    return response.text ??
        'No additional information available at this time.'; // Ensure a String is always returned
  }
}
