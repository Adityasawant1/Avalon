import 'package:flutter/material.dart';

class AppColors1 {
  static const Color backgroundColor = Color(0xFF274D46);
  static const Color avatarBackgroundColor = Color(0xFF789F8A);
  static const Color weatherContainerColor = Color(0xFF51776F);
  static const Color exploreTabSelectedColor = Colors.white;
  static const Color exploreTabUnselectedColor = Color(0xFF789F8A);
  static const Color textWhite = Colors.white;
  static const Color textBlack = Colors.black;
  static const Color deviceContainerColor = Color(0xFF789F8A);
}

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
        backgroundColor: AppColors1.backgroundColor,
        appBar: AppBar(
          title: Center(
            child: Text(
              'COMMUNITY',
              style: TextStyle(
                color: AppColors1.textWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: AppColors1.backgroundColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppColors1.avatarBackgroundColor,
                child: Icon(Icons.person, color: AppColors1.textWhite),
              ),
            )
          ],
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColors1.avatarBackgroundColor,
              child: Icon(Icons.grid_view_rounded, color: AppColors1.textWhite),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors1.weatherContainerColor,
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
    return Card(
      margin: EdgeInsets.all(10.0),
      color: AppColors1.avatarBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  project.imagePath,
                  width: 140,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      project.name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors1.textWhite),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    project.description,
                    style: TextStyle(color: AppColors1.textWhite),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    project.ngoName,
                    style: TextStyle(color: AppColors1.exploreTabSelectedColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppColors1.exploreTabSelectedColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          icon: Icon(
                            project.isLiked
                                ? Icons.arrow_upward
                                : Icons.arrow_upward_outlined,
                            color: project.isLiked ? Colors.green : Colors.grey,
                          ),
                          onPressed: onLikeButtonPressed,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors1.backgroundColor),
                        onPressed: () {
                          // Add your "I'm in" button functionality here
                        },
                        child: Text(
                          "I'm in",
                          style: TextStyle(
                              color: AppColors1.textWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
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
