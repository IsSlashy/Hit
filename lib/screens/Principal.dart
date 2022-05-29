import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'player_page.dart';

class Principal extends StatelessWidget {
  final String name;
  final String artistImage;

  const Principal({Key key, this.name, this.artistImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyappBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(
              artistImage: artistImage,
              name: name,
            ),
            PlayLisSection(
              artistName: name,
              artistImage: artistImage,
            ),
          ],
        ),
      ),
      //  bottomNavigationBar: BottomSection(),
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
  final String artistImage;
  final String name;
  const HeaderSection({Key key, this.artistImage, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
            image: NetworkImage(artistImage),
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
            child: Text(name,
                style: GoogleFonts.arizonia(
                  color: Colors.white,
                  fontSize: 43,
                  fontWeight: FontWeight.w800,
                )),
          ),
          // Positioned(
          //   right: 0,
          //   bottom: 20,
          //   child: MaterialButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => PlayerPage(
          //             name: name,
          //             artistImage: artistImage,
          //           ),
          //         ),
          //       );
          //     },
          //     color: Colors.blue,
          //     shape: CircleBorder(),
          //     child: Padding(
          //         padding: EdgeInsets.all(17),
          //         child: Icon(
          //           Icons.play_arrow_rounded,
          //           color: Colors.white,
          //           size: 30,
          //         )),
          //   ),
          // ),
        ],
      ),
    );
  }
}

getData(String artistName) async {
  List playlist = [];
  await FirebaseFirestore.instance
      .collection('Artist Songs')
      .where('ArtistName', isEqualTo: artistName)
      .get()
      .then((QuerySnapshot snapshot) {
    snapshot.docs.forEach(
      // add data to your list
      (f) => playlist.add(f.data()),
    );
  });
  return playlist;
}

class PlayLisSection extends StatelessWidget {
  final String artistName;
  final String artistImage;
  final List playList = [
    // {
    //   'title': '1939 PM',
    //   'duration': '3,30',
    //   'played': false,
    // },
    // {
    //   'title': '9AM in Calabasas',
    //   'duration': '1,47',
    //   'played': true,
    // },
  ];

  PlayLisSection({Key key, this.artistName, this.artistImage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
//    print(getData(artistName));

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
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Artist Songs')
                .where('ArtistName', isEqualTo: artistName)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              List allData = snapshot.data.docs.toList();
              if (allData.length < 0) {
                return Text("Loading");
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: allData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerPage(
                            song: allData[index]['Song'],
                            songName: allData[index]['Title'],
                            songImage: allData[index]['SongImage'],
                            name: artistName,
                            artistImage: artistImage,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 70,
                      child: Column(children: [
                        Text(allData[index]['Title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                allData[index]['Duration'],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.more_vert,
                              )
                            ])
                      ]),
                    ),
                  );
                },
              );
            },
          )
          // Column(
          //   children: getData(artistName).map((song) {
          //     return Container(
          //       height: 70,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(song['Title'],
          //               style: TextStyle(
          //                 color: song['played'] =
          //                     false ? Colors.blue : Colors.black,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w400,
          //               )),
          //           Row(
          //             children: [
          //               Text(song['Duration'],
          //                   style: TextStyle(
          //                     color: song['played'] =
          //                         false ? Colors.blue : Colors.black,
          //                   )),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Icon(
          //                 Icons.more_vert,
          //                 color: song['played'] =
          //                     false ? Colors.blue : Colors.grey,
          //               )
          //             ],
          //           )
          //         ],
          //       ),
          //     );
          //   }).toList(),
          // )
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
