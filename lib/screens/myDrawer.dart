// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _currentItem = 0;
  var list = [
    Center(child: Text("Home")),
    Center(child: Text("Favorite")),
    Center(child: Text("Search")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drawer Creation")),
      body: list[_currentItem],
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
                      "images/mypic.jpeg",
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
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentItem = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Favourite"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentItem = 1;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Search"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentItem = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
