// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/screens/myDrawer.dart';
import 'package:firebaselearning/screens/phone.dart';
import 'package:firebaselearning/screens/registration.dart';
import 'package:firebaselearning/screens/signup/page1.dart';
import 'package:firebaselearning/screens/uploadimg.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((firebaseuser) {
      if (firebaseuser == null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => RegDup()), (route) => false);
      } else {}
    });
  }

  void logout() {}

  int _currentPosition = 2;

  var list = [
    Center(
      child: Text("home"),
    ),
    Center(
      child: Text("favorite"),
    ),
    Center(
      child: Text("Search"),
    ),
    Center(
      child: Text("money"),
    ),
    Center(
      child: Column(children: [
        Text("Are you are really want to log out?"),
        ElevatedButton(onPressed: () {}, child: Text("Yes")),
      ]),
    ),
    Center(
      child: Text("settings"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((onValue) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => PageOne()),
                      (route) => false);
                });
                Fluttertoast.showToast(msg: 'logged out successfully');
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                alignment: Alignment.center,
                color: Colors.orangeAccent,
                child: Column(
                  children: [
                    Image.asset(
                      "lib/images/mypic.jpeg",
                      height: 100,
                    ),
                    Text("Ashok")
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("whatsapp"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => UploadImg()));
                setState(() {
                  _currentPosition = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("registration"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RegDup()));
                setState(() {
                  _currentPosition = 1;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Search"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentPosition = 2;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.money_off),
              title: Text("money"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentPosition = 3;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text("logout"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentPosition = 4;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("settings"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentPosition = 5;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: _currentPosition,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: " ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: " ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: " ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: " ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: " ",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentPosition = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => UploadImg()));
        },
        child: Icon(Icons.upload_file),
      ),
      body: list[_currentPosition],
    );
  }
}
