import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'player_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music player',
      home: Home(),
    );
  }
} // MaterialApp

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyappBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            PlayLisSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomSection(),
    );
  }
}

class BottomSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.pause, color: Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Text(
            "9 AM in calabasas",
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_circle_up, color: Colors.white),
          label: '',
        ),
      ],
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
            image: AssetImage('images/Carti.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
          )),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            bottom: 30,
            child: Text('Playboi Carti',
                style: GoogleFonts.arizonia(
                  color: Colors.white,
                  fontSize: 43,
                  fontWeight: FontWeight.w800,
                )),
          ),
          Positioned(
              right: 0,
              bottom: 20,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerPage(),
                    ),
                  );
                },
                color: Colors.blue,
                shape: CircleBorder(),
                child: Padding(
                    padding: EdgeInsets.all(17),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30,
                    )),
              ))
        ],
      ),
    );
  }
}

class PlayLisSection extends StatelessWidget {
  final List playList = [
    {
      'title': '1939 PM',
      'duration': '3,30',
      'played': false,
    },
    {
      'title': '9AM in Calabasas',
      'duration': '1,47',
      'played': true,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 40, 20, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  'Show All',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: playList.map((song) {
              return Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(song['title'],
                        style: TextStyle(
                          color: song['played'] ? Colors.blue : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                    Row(
                      children: [
                        Text(song['duration'],
                            style: TextStyle(
                              color:
                                  song['played'] ? Colors.blue : Colors.black,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.more_vert,
                          color: song['played'] ? Colors.blue : Colors.grey,
                        )
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class MyappBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
          size: 25,
        ),
        onPressed: null,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 25,
          ),
          onPressed: null,
        ),
      ],
      backgroundColor: Colors.white.withOpacity(0),
    );
  }
}
