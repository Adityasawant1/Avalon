import 'package:avalon/Services/country_state_city_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:avalon/utils/NGO_Reg_Model.dart';
import 'package:avalon/theme/colors.dart';

class RegisterNGOPage extends StatefulWidget {
  @override
  _RegisterNGOPageState createState() => _RegisterNGOPageState();
}

class _RegisterNGOPageState extends State<RegisterNGOPage> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;

  // Controllers for form fields
  final _organizationNameController = TextEditingController();
  final _organizationBioController = TextEditingController();
  final _websiteController = TextEditingController();
  final _contactDetailsController = TextEditingController();

  String? _selectedCategory;
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  List<dynamic> _countries = [];
  List<dynamic> _states = [];
  List<dynamic> _cities = [];

  final CountryStateCityService _countryStateCityService =
      CountryStateCityService();

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      final countries = await _countryStateCityService.fetchCountries();
      setState(() {
        _countries = countries;
      });
    } catch (e) {
      print('Error loading countries: $e');
    }
  }

  Future<void> _loadStates(String countryCode) async {
    try {
      final states = await _countryStateCityService.fetchStates(countryCode);
      setState(() {
        _states = states;
        _selectedState = null;
        _cities = [];
        _selectedCity = null;
      });
    } catch (e) {
      print('Error loading states: $e');
    }
  }

  Future<void> _loadCities(String countryCode, String stateCode) async {
    try {
      final cities =
          await _countryStateCityService.fetchCities(countryCode, stateCode);
      setState(() {
        _cities = cities;
        _selectedCity = null;
      });
    } catch (e) {
      print('Error loading cities: $e');
    }
  }

  @override
  void dispose() {
    _organizationNameController.dispose();
    _organizationBioController.dispose();
    _websiteController.dispose();
    _contactDetailsController.dispose();
    super.dispose();
  }

  // Predefined categories
  final List<String> categories = [
    'Environmental',
    'Advocacy',
    'Development',
    'Humanitarian',
  ];

  Future<void> _registerNGO() async {
    if (_formKey.currentState!.validate()) {
      // Create NGO object
      NGO ngo = NGO(
        organizationName: _organizationNameController.text,
        organizationBio: _organizationBioController.text,
        category: _selectedCategory!,
        country: _selectedCountry ?? '',
        location: '$_selectedState, $_selectedCity',
        website: _websiteController.text,
        contactDetails: _contactDetailsController.text,
      );

      // Save to Firestore
      try {
        await _firestore.collection('ngos').add(ngo.toMap());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('NGO registered successfully!')),
        );
        Navigator.pop(context);
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register NGO. Please try again.')),
        );
      }
    }
  }

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
            colors: [
              backgroundColor2,
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                // Title
                Text(
                  'Register Your NGO',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: textColor1,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _organizationNameController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Enter Organization Name",
                          labelText: "Organization Name",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the organization name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        controller: _organizationBioController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Enter Organization Bio",
                          labelText: "Organization Bio",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the organization bio';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Select Category",
                          labelText: "Category",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      DropdownButtonFormField<String>(
                        value: _selectedCountry,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Select Country",
                          labelText: "Country",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: _countries.map((country) {
                          return DropdownMenuItem<String>(
                            value: country['iso2'],
                            child: Text(country['name']),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCountry = newValue;
                            if (newValue != null) {
                              _loadStates(newValue);
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a country';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      DropdownButtonFormField<String>(
                        value: _selectedState,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Select State",
                          labelText: "State",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: _states.map((state) {
                          return DropdownMenuItem<String>(
                            value: state['iso2'],
                            child: Text(state['name']),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedState = newValue;
                            if (newValue != null && _selectedCountry != null) {
                              _loadCities(_selectedCountry!, newValue);
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a state';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      DropdownButtonFormField<String>(
                        value: _selectedCity,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Select City",
                          labelText: "City",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: _cities.map((city) {
                          return DropdownMenuItem<String>(
                            value: city['name'],
                            child: Text(city['name']),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCity = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a city';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        controller: _websiteController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Enter Website URL",
                          labelText: "Website",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the website URL';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        controller: _contactDetailsController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          hintText: "Enter Contact Details",
                          labelText: "Contact Details",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter contact details';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.04),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _registerNGO,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: buttonColor, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
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
}
