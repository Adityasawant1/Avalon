import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NGOProfilePage extends StatefulWidget {
  @override
  _NGOProfilePageState createState() => _NGOProfilePageState();
}

class _NGOProfilePageState extends State<NGOProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  String _ngoName = '';
  String _ngoBio = '';
  bool _isOwner = false;
  bool _hasNGO = false;

  TextEditingController _campaignNameController = TextEditingController();
  TextEditingController _campaignDescriptionController =
      TextEditingController();
  TextEditingController _campaignImageURLController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _fetchNGODetails();
  }

  Future<void> _fetchNGODetails() async {
    if (_user == null) return;

    QuerySnapshot ngoQuery = await _firestore
        .collection('ngos')
        .where('ownerId', isEqualTo: _user!.uid)
        .limit(1)
        .get();

    if (ngoQuery.docs.isNotEmpty) {
      DocumentSnapshot ngoDoc = ngoQuery.docs.first;
      setState(() {
        _ngoName = ngoDoc['organizationName'];
        _ngoBio = ngoDoc['organizationBio'];
        _isOwner = ngoDoc['ownerId'] == _user?.uid;
        _hasNGO = true;
      });
    } else {
      setState(() {
        _hasNGO = false;
        _ngoName =
            _user!.displayName ?? 'User'; // Default to username if available
        _ngoBio = ''; // Optionally set default bio or leave empty
      });
    }
  }

  Future<void> _editNGODetails() async {
    if (_user == null) return;

    // Navigate to edit page with current NGO details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNGODetailsPage(
          ngoName: _ngoName,
          ngoBio: _ngoBio,
          onSave: (name, bio) async {
            if (_user == null) return;

            await _firestore.collection('ngos').doc(_user!.uid).update({
              'organizationName': name,
              'organizationBio': bio,
            });

            setState(() {
              _ngoName = name;
              _ngoBio = bio;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGO Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            SizedBox(height: 16),
            Text(
              _ngoName.isNotEmpty ? _ngoName : 'Loading...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              _ngoBio.isNotEmpty ? _ngoBio : 'Loading...',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            if (_isOwner)
              ElevatedButton(
                onPressed: _editNGODetails,
                child: Text('Edit NGO Details'),
              ),
          ],
        ),
      ),
      floatingActionButton: _hasNGO
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Upload Campaign'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _campaignNameController,
                            decoration:
                                InputDecoration(labelText: 'Campaign Name'),
                          ),
                          TextField(
                            controller: _campaignDescriptionController,
                            decoration: InputDecoration(
                                labelText: 'Campaign Description'),
                          ),
                          TextField(
                            controller: _campaignImageURLController,
                            decoration: InputDecoration(labelText: 'Image URL'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_user == null) return;

                            await _firestore.collection('campaigns').add({
                              'name': _campaignNameController.text,
                              'description':
                                  _campaignDescriptionController.text,
                              'imageURL': _campaignImageURLController.text,
                              'ngoName':
                                  _ngoName, // Provide the NGO name dynamically
                              'ownerId': _user?.uid,
                            });

                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Campaign uploaded successfully!')),
                            );
                          },
                          child: Text('Upload'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.add),
              tooltip: 'Upload Campaign',
            )
          : null, // Hide the FloatingActionButton if no NGO is registered
    );
  }
}

// Dummy EditNGODetailsPage for editing NGO details
class EditNGODetailsPage extends StatelessWidget {
  final String ngoName;
  final String ngoBio;
  final Function(String name, String bio) onSave;

  final TextEditingController _nameController;
  final TextEditingController _bioController;

  EditNGODetailsPage({
    required this.ngoName,
    required this.ngoBio,
    required this.onSave,
  })  : _nameController = TextEditingController(text: ngoName),
        _bioController = TextEditingController(text: ngoBio);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit NGO Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Organization Name'),
            ),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Organization Bio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onSave(
                  _nameController.text,
                  _bioController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
