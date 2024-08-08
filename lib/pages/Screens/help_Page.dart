import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppColorsHelp {
  static const Color backgroundColor = Color(0xFF274D46);
  static const Color avatarBackgroundColor = Color(0xFF789F8A);
  static const Color weatherContainerColor = Color(0xFF51776F);
  static const Color exploreTabSelectedColor = Colors.white;
  static const Color exploreTabUnselectedColor = Color(0xFF789F8A);
  static const Color textWhite = Colors.white;
  static const Color textBlack = Colors.black;
  static const Color deviceContainerColor = Color(0xFF789F8A);
}

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  final _contactController = TextEditingController();
  final _feedbackRef = FirebaseFirestore.instance.collection('feedback');

  int _feedbackLetterCount = 0;
  final int _maxLetterCount = 500;

  final List<Map<String, String>> faqs = [
    {
      'question': 'How can I reset my password?',
      'answer': 'To reset your password, go to Settings > Change Password.'
    },
    {
      'question': 'How can I change my email address?',
      'answer':
          'To change your email address, go to Settings > Account Info and update your email.'
    },
    {
      'question': 'How can I delete my account?',
      'answer':
          'To delete your account, please contact our support team at support@example.com.'
    },
    {
      'question': 'How do I report a bug?',
      'answer':
          'To report a bug, go to Help > Feedback and describe the issue you encountered.'
    },
    {
      'question': 'How can I contact support?',
      'answer': 'You can contact support by emailing us at support@example.com.'
    },
    {
      'question': 'Where can I find the privacy policy?',
      'answer':
          'Our privacy policy is available at www.example.com/privacy-policy.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade100,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Text(
                  'Help',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 39,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Frequently Asked Questions',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(height: 20),
                ...faqs.map((faq) => FaqItem(faq: faq)).toList(),
                const SizedBox(height: 20),
                const Text(
                  'We are here to help!',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          TextFormField(
                            controller: _feedbackController,
                            maxLines: 5,
                            style: const TextStyle(color: HtextColor1),
                            decoration: InputDecoration(
                              labelText: 'Your Feedback',
                              labelStyle: const TextStyle(color: Colors.black),
                              fillColor: Color.fromARGB(255, 100, 121, 130),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (text) {
                              setState(() {
                                _feedbackLetterCount = text.length;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide your feedback';
                              }
                              if (_feedbackLetterCount > _maxLetterCount) {
                                return 'Feedback cannot exceed $_maxLetterCount letters';
                              }
                              return null;
                            },
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: Text(
                              '$_feedbackLetterCount/$_maxLetterCount letters',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _contactController,
                        style: const TextStyle(color: HtextColor1),
                        decoration: InputDecoration(
                          labelText: 'Your Email',
                          labelStyle: const TextStyle(color: Colors.black),
                          fillColor: Color.fromARGB(255, 100, 121, 130),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide your contact email';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitFeedback,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      _feedbackRef.add({
        'feedback': _feedbackController.text,
        'contact': _contactController.text,
        'timestamp': DateTime.now().toIso8601String(),
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback submitted successfully')),
        );
        _feedbackController.clear();
        _contactController.clear();
        setState(() {
          _feedbackLetterCount = 0;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit feedback')),
        );
      });
    }
  }
}

class FaqItem extends StatefulWidget {
  final Map<String, String> faq;
  FaqItem({required this.faq});

  @override
  _FaqItemState createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey.shade500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
        title: Text(
          widget.faq['question']!,
          style: TextStyle(color: HtextColor1),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.faq['answer']!,
              style: TextStyle(color: HtextColor1),
            ),
          ),
        ],
        trailing: Icon(
          _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: HtextColor1,
        ),
        onExpansionChanged: (bool expanded) {
          setState(() => _isExpanded = expanded);
        },
      ),
    );
  }
}

//color theme for this page

const HtextColor1 = Colors.white;
