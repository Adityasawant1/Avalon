import 'package:avalon/pages/Home/main_home_page.dart';
import 'package:avalon/AI%20Features/PlantIdentifire.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Geminitool extends StatefulWidget {
  @override
  _Geminitool createState() => _Geminitool();
}

class _Geminitool extends State<Geminitool>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          },
        ),
        title: const Center(
          child: Text(
            'AI Features',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/e1.png'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideTransition(
                  position: _offsetAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF242424),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.mic, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Voice rec',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Take your sound of voice to analyze voice features...',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SlideTransition(
                  position: _offsetAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF242424),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.mood, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Emotions ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Take your sound of voice to analyze voice features...',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _offsetAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Research & Analysis',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.more_vert, color: Colors.white),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(10),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PlantScannerPage(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey.shade500,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Scan Plant to',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Care',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundColor:
                                                  Color(0xFFE0E0E0),
                                              child: Icon(
                                                FontAwesomeIcons.seedling,
                                                color: Color.fromRGBO(
                                                    36, 36, 36, 1),
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey.shade500,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pollution',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'AIR',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Color(0xFFE0E0E0),
                                            child: Icon(
                                              FontAwesomeIcons.wind,
                                              color: Color(0xFF242424),
                                              size: 21,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey.shade500,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pollution',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'WATER',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Color(0xFFE0E0E0),
                                            child: Icon(
                                              FontAwesomeIcons.droplet,
                                              color: Color(0xFF242424),
                                              size: 21,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey.shade500,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pollution',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'GLESSURE',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Color(0xFFE0E0E0),
                                            child: Icon(
                                              FontAwesomeIcons.icicles,
                                              color: Color(0xFF242424),
                                              size: 21,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
