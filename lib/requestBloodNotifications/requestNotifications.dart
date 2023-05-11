import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/requestBloodNotifications/allRequests.dart';
import 'package:firebaselearning/requestBloodNotifications/myRequests.dart';
import 'package:firebaselearning/requestBloodNotifications/nearByRequests.dart';
import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  String town;
  Requests({Key? key, required this.town}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(75, 0, 130, 1),
            elevation: 18,
            shadowColor: Colors.black,
            title: Text("Requests"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MyRequests(
                                phone: FirebaseAuth.instance.currentUser!
                                    .phoneNumber as String)));
                  },
                  icon: Icon(Icons.my_library_add))
            ],
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  icon: Icon(Icons.near_me_outlined),
                  child: Text("Near By Requests"),
                ),
                Tab(
                  icon: Icon(Icons.all_inclusive_outlined),
                  child: Text("All Requests"),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            NearByRequests(
              town: widget.town,
            ),
            AllRequets(),
          ]),
        ));
  }
}
