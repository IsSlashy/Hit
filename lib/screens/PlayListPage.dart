import 'package:flutter/material.dart';

class PlayListPage extends StatelessWidget {
  List<String> CoverList = [
    "images/Fav/9am.jpg",
    "images/Fav/DR.jpg",
    "images/Fav/St.jpg",
    "images/Fav/jc.jpg",
    "images/Fav/X.jpg",
    "images/Fav/Msk.jpg"
  ];

  Widget ListItem(String CoverUrl, String AlbumTitle, String SingerName) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Container(
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    child: Image.network(CoverUrl),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AlbumTitle,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      SingerName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Your Favorite Music",
              style: TextStyle(color: Colors.white, fontSize: 28.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListItem(CoverList[0], "9AM", "Playboi Carti"),
                  ListItem(CoverList[1], "God's Plan", "Drake"),
                  ListItem(CoverList[2], "Stargazing", "Travis Scott"),
                  ListItem(CoverList[3], "Lucid Dreams", "Juice WLRD"),
                  ListItem(CoverList[4], "SAD !", "XTentation"),
                  ListItem(CoverList[5], "Mask Off", "Future"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
