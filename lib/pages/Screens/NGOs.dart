// import 'package:avalon/pages/Screens/SelectedNGo.dart';
// import 'package:avalon/utils/NGO_Reg_Model.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:avalon/theme/inside_color.dart';

// class CollaborationPage extends StatefulWidget {
//   @override
//   State<CollaborationPage> createState() => _CollaborationPageState();
// }

// class _CollaborationPageState extends State<CollaborationPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );

//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Function to launch the URL in the default browser
//   Future<void> _launchURL(String url) async {
//     final Uri uri = Uri.parse(url);
//     if (!await launchUrl(uri)) {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             if (Navigator.of(context).canPop()) {
//               Navigator.of(context).pop();
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('No previous page to go back to!')),
//               );
//             }
//           },
//         ),
//         backgroundColor: Colors.blueGrey.shade100,
//         title: Center(
//           child: Text(
//             'N G O',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         actions: [
//           CircleAvatar(
//             backgroundImage: AssetImage('assets/images/e1.png'),
//           ),
//           SizedBox(width: 10),
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('ngos').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData) {
//             return Center(
//               child: Text(
//                 'No NGOs registered yet.',
//                 style: TextStyle(color: AppColors1.textWhite),
//               ),
//             );
//           }

//           final ngos = snapshot.data!.docs.map((doc) {
//             return NGO.fromMap(doc.data() as Map<String, dynamic>);
//           }).toList();

//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.blueGrey.shade100,
//                   Colors.white,
//                 ],
//               ),
//             ),
//             child: SlideTransition(
//               position: _slideAnimation,
//               child: ListView.builder(
//                 itemCount: ngos.length,
//                 itemBuilder: (context, index) {
//                   final ngo = ngos[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => NGOListPage(ngo: ngo),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       width: size.width * 0.9,
//                       margin: EdgeInsets.only(
//                           left: 20, right: 20, top: 15, bottom: 20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.25),
//                             offset: Offset(4, 4),
//                             blurRadius: 10,
//                             spreadRadius: 1,
//                           ),
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.15),
//                             offset: Offset(-4, -4),
//                             blurRadius: 10,
//                             spreadRadius: 1,
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: size.height * 0.4,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Image.asset(
//                                   'assets/images/e3.png',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             // NGO Name
//                             Center(
//                               child: Text(
//                                 ngo.organizationName,
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             const SizedBox(height: 2),
//                             // NGO Category
//                             Text(
//                               ngo.category,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16,
//                                 color: Colors.grey[800],
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             SizedBox(height: 2),
//                             // NGO Bio
//                             Text(
//                               ngo.organizationBio,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey[700],
//                               ),
//                               maxLines: 3,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 3),
//                             // Website
//                             GestureDetector(
//                               onTap: () => _launchURL(ngo.website),
//                               child: Text(
//                                 ngo.website,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.blue,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                             ),
//                             SizedBox(height: 3),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.location_on,
//                                   color: Colors.grey[700],
//                                 ),
//                                 SizedBox(width: 5),
//                                 Text(
//                                   "${ngo.location}, ${ngo.country} ",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey[700],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
