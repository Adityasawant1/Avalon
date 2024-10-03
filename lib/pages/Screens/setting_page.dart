import 'dart:io';
import 'package:avalon/pages/Screens/RegisterNGOPage.dart';
import 'package:avalon/pages/Screens/change_pass.dart';
import 'package:avalon/pages/Screens/help_Page.dart';
import 'package:avalon/theme/inside_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  // Get the current user
  User? user = FirebaseAuth.instance.currentUser;

  // Image picker
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _name;
  String? _email;

  // Firebase Storage
  final FirebaseStorage storage = FirebaseStorage.instance;

  // TextEditingController for Name and Email
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  // State for logout loading
  bool _isSigningOut = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
    _name = user?.displayName;
    _email = user?.email;

    // Initialize the controllers
    _nameController = TextEditingController(text: _name);
    _emailController = TextEditingController(text: _email);
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
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
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              SlideTransition(
                position: _slideAnimation,
                child: AccountSection(
                  user: user,
                  selectedImage: _selectedImage,
                  onImageSelected: _selectImage,
                  onImageUploaded: _uploadImageToFirebase,
                  name: _name,
                  email: _email,
                  onEditProfile: () {
                    _showEditProfileDialog(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _slideAnimation,
                child: SettingsSection(
                  onLogout: _signOut,
                  isSigningOut: _isSigningOut,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_selectedImage != null) {
      // Create a reference to the file in Firebase Storage
      Reference ref = storage.ref().child('profilePictures/${user?.uid}');
      // Upload the file to the reference
      try {
        await ref.putFile(_selectedImage!);
        // Get the download URL
        String downloadURL = await ref.getDownloadURL();
        // Update user's profile picture in the database
        await user?.updatePhotoURL(downloadURL);
      } catch (e) {
        print('Error uploading image: $e');
        // Handle the error, for example, display a message to the user
      }
    }
  }

  Future<void> _signOut() async {
    setState(() {
      _isSigningOut = true;
      //Firebase Logout
      FirebaseAuth.instance.signOut();
      //Google Logout
      GoogleSignIn().signOut();
    });
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();

      // After sign out, navigate to your login or authentication screen
      Navigator.pushReplacementNamed(
          context, '/login'); // Replace '/login' with your actual login route
    } catch (e) {
      // Handle sign out errors if needed
      print('Error signing out: $e');
    } finally {
      setState(() {
        _isSigningOut = false;
      });
    }
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image selection
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : user?.photoURL != null
                            ? NetworkImage(user!.photoURL!) as ImageProvider
                            : const AssetImage(
                                'assets/images/settingprofile.png',
                              ), // Replace with your image asset
                  ),
                  IconButton(
                    onPressed: () => _selectImage(),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Name input
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 16),
              // Email input (read-only)
              TextField(
                controller: _emailController,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Update user information in Firebase
                if (_selectedImage != null) {
                  await _uploadImageToFirebase();
                }
                await user?.updateDisplayName(_nameController.text);
                // Update name in the state for immediate display
                setState(() {
                  _name = _nameController.text;
                });
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class AccountSection extends StatelessWidget {
  final User? user;
  final File? selectedImage;
  final Function onImageSelected;
  final Function onImageUploaded;
  final String? name;
  final String? email;
  final Function onEditProfile;

  AccountSection({
    required this.user,
    this.selectedImage,
    required this.onImageSelected,
    required this.onImageUploaded,
    this.name,
    this.email,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ]),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : user?.photoURL != null
                        ? NetworkImage(user!.photoURL!) as ImageProvider
                        : const AssetImage(
                            'assets/images/settingprofile.png',
                          ), // Replace with your image asset
              ),
              IconButton(
                onPressed: () => onImageSelected(),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            name ?? "User Name",
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text(
            email ?? "User Email",
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => onEditProfile(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(color: AppColors1.textWhite),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatefulWidget {
  final Function onLogout;
  final bool isSigningOut;

  const SettingsSection({required this.onLogout, required this.isSigningOut});

  @override
  _SettingsSectionState createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ]),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.orange),
            title: const Text('Register your Company',
                style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterNGOPage()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.green),
            title: const Text('Change Password',
                style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.dark_mode, color: Colors.purple),
            title:
                const Text('Dark Mode', style: TextStyle(color: Colors.black)),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
              activeColor: Colors.purple,
            ),
            onTap: () {},
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.red),
            title: const Text('Help', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPage()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.black)),
            onTap: () {
              _signOut();
            },
            // Add loading indicator
            trailing: widget.isSigningOut
                ? const CircularProgressIndicator()
                : const Icon(Icons.arrow_forward_ios, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

Future<void> _signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    // Handle sign out errors if needed
    print('Error signing out: $e');
  }
}
