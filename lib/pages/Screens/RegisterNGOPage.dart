import 'package:avalon/utils/NGO_Reg_Model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterNGOPage extends StatefulWidget {
  @override
  _RegisterNGOPageState createState() => _RegisterNGOPageState();
}

class _RegisterNGOPageState extends State<RegisterNGOPage> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _contactDetailsController =
      TextEditingController();

  void _registerNGO() async {
    if (_formKey.currentState!.validate()) {
      // Get the current user's UID
      final User? user = _auth.currentUser;

      // Create a new NGO instance
      NGO newNGO = NGO(
        organizationName: _nameController.text,
        organizationBio: _bioController.text,
        category: _categoryController.text,
        country: _countryController.text,
        location: _locationController.text,
        website: _websiteController.text,
        contactDetails: _contactDetailsController.text,
        ownerId: user?.uid, // Set the ownerId to the current user's UID
      );

      // Save the NGO to Firestore
      await _firestore.collection('ngos').add(newNGO.toMap());

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('NGO registered successfully!')),
      );

      // Clear the form
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the organization name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bioController,
                  decoration: InputDecoration(labelText: 'Qualification'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the organization bio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the category';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the country';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _websiteController,
                  decoration: InputDecoration(labelText: 'Resume'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the website';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _contactDetailsController,
                  decoration: InputDecoration(
                      labelText: 'Additional Hobby Information'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the contact details';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerNGO,
                  child: Text('Go For Text'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
