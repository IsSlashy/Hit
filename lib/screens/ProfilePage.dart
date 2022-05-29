import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/authentication_service.dart';
import 'package:provider/src/provider.dart';

FirebaseAuth _user = FirebaseAuth.instance;

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(_user.currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        print(_user.currentUser.uid);
        
        print(snapshot.data.data());
        if (snapshot.hasData) {
          return Center(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 22.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage("images/Spidy.jpg"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Unity Fx",
                  style: TextStyle(color: Colors.white, fontSize: 28.0),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "0",
                            style:
                                TextStyle(color: Colors.green, fontSize: 35.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Music",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Premium",
                            style: TextStyle(
                                color: Colors.yellowAccent, fontSize: 35.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Level",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "1k",
                            style: TextStyle(color: Colors.red, fontSize: 35.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.all(22.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 18.0),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ),
                    color: Color(0xFF1DD860),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(22.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 18.0),
                      child: Text(
                        "Sign out",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ),
                    color: Color(0xFFF00E0E),
                    onPressed: () {
                      context.read<AuthenticationService>().signOut();
                    },
                  ),
                ),
              ],
            ),
          ));
        }
        return CircleAvatar();
      },
    );
  }
}
