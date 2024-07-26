import 'package:flutter/material.dart';

class LeaderBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Center(
          child: Text(
            "Leader Board",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Icon(Icons.more_vert),
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
              
            }),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          TopThreeWidget(),
          const SizedBox(height: 5,),
          Expanded(child: LeaderBoardList()),
        ],
      ),
    );
  }
}


class TopThreeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF6A0DAD), // Purple color for the top three container
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TopThreePlayerWidget(
                rank: 2,
                name: "Elon Musk",
                points: 100,
                imagePath: 'assets/images/jacob.png',
              ),
              TopThreePlayerWidget(
                rank: 1,
                name: "Jefry Bezos",
                points: 75,
                imagePath: 'assets/images/login.png',
              ),
              TopThreePlayerWidget(
                rank: 3,
                name: "Taklu gates",
                points: 50,
                imagePath: 'assets/images/jenny.png',
              ),
            ],
          ),
          SizedBox(height: 16),
          Icon(
            Icons.emoji_events,
            color: Colors.yellow,
            size: 40,
          ),
        ],
      ),
    );
  }
}

class TopThreePlayerWidget extends StatelessWidget {
  final int rank;
  final String name;
  final int points;
  final String imagePath;

  TopThreePlayerWidget(
      {required this.rank, required this.name, required this.points, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 40,
            ),
            if (rank == 1)
              Positioned(
                top: 45,
                child: Icon(
                  Icons.emoji_events,
                  color: Colors.yellow,
                  size: 50,
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Text(
          points.toString(),
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}

class LeaderBoardList extends StatelessWidget {
  final List<Player> players = [
    Player(rank: 4, name: "Darlene Robertson", points: 800, imagePath: 'assets/images/darlene.png'),
    Player(rank: 5, name: "Jenny Wilson", points: 700, imagePath: 'assets/images/jenny.png'),
    Player(rank: 6, name: "Emmanuel Christensen", points: 650, imagePath: 'assets/images/emmanuel.png'),
    Player(rank: 7, name: "Jane Cooper", points: 580, imagePath: 'assets/images/jane.png'),
    Player(rank: 8, name: "Courtney Henry", points: 530, imagePath: 'assets/images/courtney.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        return LeaderBoardTile(player: players[index]);
      },
    );
  }
}

class Player {
  final int rank;
  final String name;
  final int points;
  final String imagePath;

  Player({required this.rank, required this.name, required this.points, required this.imagePath});
}

class LeaderBoardTile extends StatelessWidget {
  final Player player;

  LeaderBoardTile({required this.player});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(player.imagePath),
              radius: 28,
            ),
            title: Text(
              player.name,
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              player.points.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
