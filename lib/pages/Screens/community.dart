import 'package:avalon/theme/inside_color.dart';
import 'package:flutter/material.dart';

class Project {
  final String name;
  final String description;
  final String ngoName;
  final String imagePath;
  bool isLiked;

  Project({
    required this.name,
    required this.description,
    required this.ngoName,
    required this.imagePath,
    this.isLiked = false,
  });
}

class ProjectListScreen extends StatefulWidget {
  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final List<Project> projects = [
    Project(
      name: 'Project name',
      description:
          'Some row information about project that gives information to people about project',
      ngoName: 'NGO NAME',
      imagePath: 'assets/images/NGO.png',
    ),
    Project(
      name: 'Project name',
      description:
          'Some row information about project that gives information to people about project',
      ngoName: 'NGO NAME',
      imagePath: 'assets/images/NGO1.png',
    ),
    // Add more projects if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: AppColors1.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade100,
          title: Center(
            child: Text(
              'COMMUNITY',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // backgroundColor: AppColors1.backgroundColor,
          actions: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/e1.png'),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Container(
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
          child: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        // backgroundColor: AppColors1.weatherContainerColor,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                projects[index].imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              projects[index].name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors1.textWhite,
                              ),
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                projects[index].description,
                                style: TextStyle(color: AppColors1.textWhite),
                              ),
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'More Project Details',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                projects[index].ngoName,
                                style: TextStyle(
                                  color: AppColors1.avatarBackgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: ProjectCard(
                  project: projects[index],
                  onLikeButtonPressed: () {
                    setState(() {
                      projects[index].isLiked = !projects[index].isLiked;
                    });
                  },
                ),
              );
            },
          ),
        ));
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onLikeButtonPressed;

  ProjectCard({
    required this.project,
    required this.onLikeButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      //color: AppColors1.weatherContainerColor, // Darker grey color
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                project.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    project.description,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    project.ngoName,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.green.shade500,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(3, 5),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            project.isLiked
                                ? Icons.arrow_upward
                                : Icons.arrow_upward_outlined,
                            color:
                                project.isLiked ? Colors.white : Colors.black,
                          ),
                          onPressed: onLikeButtonPressed,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(3, 5),
                          ),
                        ], borderRadius: BorderRadius.circular(30)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            // Add your "I'm in" button functionality here
                          },
                          child: Text(
                            "I'm in",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
