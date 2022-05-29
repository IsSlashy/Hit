import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/Principal.dart';
import 'PlayListPage.dart';
import 'ProfilePage.dart';
import 'SearchPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _courentTab = 0;
  final Tabs = [
    Screen(),
    SearchPage(),
    PlayListPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Tabs[_courentTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _courentTab,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "Home",
              backgroundColor: Color.fromARGB(255, 20, 20, 20),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: "Search",
              backgroundColor: Color.fromARGB(255, 20, 20, 20),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_music,
                color: Colors.white,
              ),
              label: "Music Library",
              backgroundColor: Color.fromARGB(255, 20, 20, 20),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: "Your Account",
              backgroundColor: Color.fromARGB(255, 25, 20, 20),
            ),
          ],
          onTap: (index) {
            setState(() {
              _courentTab = index;
            });
          },
        ),
      ),
    );
  }
}

class Screen extends StatelessWidget {
  List CoverList = [
    "images/Carti.png",
    "images/Drake1.jpg",
    "images/Travis.jpg",
    "images/JW.jpg",
    "images/X.jpg",
    "images/future.png"
  ];
  Widget AlbumContainer(
      String CoverUrl, String CoverName, String SingerName, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Principal(
                          artistImage: CoverUrl,
                          name: SingerName,
                        )));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
                height: 120.0, width: 200.0, child: Image.network(CoverUrl)),
          ),
        ),
        SizedBox(
          height: 1.0,
        ),
        Text(
          CoverName,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22.0),
        ),
        SizedBox(
          height: 1.0,
        ),
        Text(
          SingerName,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18.0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Recommended for you",
              style: TextStyle(color: Colors.white, fontSize: 28.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('Artist')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    var data = snapshot.data.docs.toList();
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          if (snapshot.hasError) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return AlbumContainer(
                              data[index]['CoverUrl'],
                              data[index]['CoverName'],
                              data[index]['SingerName'],
                              context);
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
            Text(
              "New Music",
              style: TextStyle(color: Colors.white, fontSize: 28.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('New Music')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var data = snapshot.data.docs.toList();
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return AlbumContainer(
                              data[index]['CoverUrl'],
                              data[index]['CoverName'],
                              data[index]['SingerName'],
                              context);
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
