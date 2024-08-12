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
        _ngoName = _user!.displayName ?? 'User';
        _ngoBio = '';
      });
    }
  }

  Future<void> _editNGODetails() async {
    if (_user == null) return;

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

  Future<void> _addCampaign() async {
    if (_user == null) return;

    String campaignName = _campaignNameController.text;
    String campaignDescription = _campaignDescriptionController.text;
    String campaignImageURL = _campaignImageURLController.text;

    await _firestore.collection('campaigns').add({
      'ngoId': _user!.uid,
      'campaignName': campaignName,
      'campaignDescription': campaignDescription,
      'imageURL': campaignImageURL,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _campaignNameController.clear();
    _campaignDescriptionController.clear();
    _campaignImageURLController.clear();
  }

  void _showCampaignDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Campaign'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _campaignNameController,
              decoration: InputDecoration(hintText: 'Campaign Name'),
            ),
            TextField(
              controller: _campaignDescriptionController,
              decoration: InputDecoration(hintText: 'Campaign Description'),
            ),
            TextField(
              controller: _campaignImageURLController,
              decoration: InputDecoration(hintText: 'Campaign Image URL'),
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
              await _addCampaign();
              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade500,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(_ngoName.isNotEmpty ? _ngoName : 'Loading...'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blueGrey.shade500,
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/profile.png'),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _ngoName.isNotEmpty ? _ngoName : 'Loading...',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  _ngoBio.isNotEmpty ? _ngoBio : 'Loading...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Website - CreativeInfos.com',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Campaigns',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '2,940',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Stars',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_isOwner)
                            ElevatedButton(
                              onPressed: _editNGODetails,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade600,
                                padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          SizedBox(width: 10),
                          if (_isOwner && _hasNGO)
                            ElevatedButton(
                              onPressed: _showCampaignDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade600,
                                padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Add Campaign',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Divider(color: Colors.grey[800]),
                if (_hasNGO)
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('campaigns')
                        .where('ngoId', isEqualTo: _user!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final campaigns = snapshot.data!.docs;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: campaigns.length,
                          itemBuilder: (context, index) {
                            final campaign = campaigns[index];
                            return Card(
                              elevation: 2,
                              margin: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 0,
                              ),
                              child: ListTile(
                                leading: Image.network(
                                  campaign['imageURL'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(campaign['campaignName']),
                                subtitle: Text(campaign['campaignDescription']),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditNGODetailsPage extends StatelessWidget {
  final String ngoName;
  final String ngoBio;
  final Function(String, String) onSave;

  EditNGODetailsPage({
    required this.ngoName,
    required this.ngoBio,
    required this.onSave,
  });

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = ngoName;
    _bioController.text = ngoBio;

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
              decoration: InputDecoration(labelText: 'NGO Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'NGO Bio'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                onSave(_nameController.text, _bioController.text);
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
