import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaselearning/bdapp/FAQ.dart';
import 'package:firebaselearning/bdapp/delete.dart';
import 'package:firebaselearning/bdapp/donarsList.dart';
import 'package:firebaselearning/bdapp/donateOrReceive.dart';
import 'package:firebaselearning/bdapp/donateUs.dart';
import 'package:firebaselearning/bdapp/problem.dart';
import 'package:firebaselearning/bdapp/requestOne.dart';
import 'package:firebaselearning/main.dart';
import 'package:firebaselearning/requestBloodNotifications/myRequests.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:firebaselearning/bdapp/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebaselearning/bdapp/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../requestBloodNotifications/requestNotifications.dart';

class Hmpg extends StatefulWidget {
  var phone;

  Hmpg({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<Hmpg> createState() => _HmpgState();
}

class _HmpgState extends State<Hmpg> {
  void getInitialMessage() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("imageUsers")
        .doc(widget.phone)
        .get();

    String town = snapshot["town"].toString();

    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      if (message.data["value"] == "request") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Requests(
                      town: town,
                    )));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getInitialMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelShowBadge: true,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("imageUsers")
          .doc(widget.phone)
          .get();

      String town = snapshot["town"].toString();

      print("app opened by message");
      if (message != null) {
        if (message.data["value"] == "request") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Requests(town: town)));
        }
      }
    });
  }

  InputDecoration inputDecoration = InputDecoration(
    prefixIcon: Icon(
      Icons.place,
      color: Color.fromRGBO(75, 0, 130, 1),
    ),
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(75, 0, 130, 1), width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(75, 0, 130, 1), width: 3),
      borderRadius: BorderRadius.circular(10),
    ),
    filled: false,
    fillColor: Colors.blueAccent[100],
  );
  TextStyle textStyle =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  Color iconColor = Color.fromRGBO(75, 0, 130, 1);
  int _currentIndex = 1;
  var bloodGroups = ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'];
  var selectedBG = null;

  var countries = ['select country', 'India'];
  var selCountry = 'select country';

  var states = ['select state'];
  var selState = 'select state';

  var districts = ['select district'];
  var selDistrict = 'select district';

  var localities = [
    'select locality',
  ];

  Color tileColor = Colors.white;
  var selLocality = 'select locality';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var list = [
      Center(
          child: SizedBox(
        height: 200,
        width: 200,
        child: FittedBox(
          child: Center(
            child: FloatingActionButton(
              elevation: 20,
              highlightElevation: 20,
              focusColor: Colors.blue,
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RequestOne()));
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Request ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(75, 0, 130, 1),
                          fontSize: 8,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " Blood",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(75, 0, 130, 1),
                          fontSize: 8,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
      SingleChildScrollView(
        child: Center(
          child: Container(
            width: 280,
            child: Column(
              children: [
                Text(
                  "Search For Blood",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            blurRadius: 1.0,
                            color: Color.fromRGBO(75, 0, 130, 1))
                      ],
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20,
                ),

                //select country
                DropdownButtonFormField(
                  value: selCountry,
                  style: textStyle,
                  items: countries.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selCountry = item as String;
                    });
                    setState(() {
                      if (selCountry == 'India') {
                        setState(() {
                          states = ['select state', 'AndhraPradesh'];
                        });
                      } else if (selCountry == 'select country') {
                        setState(() {
                          states = ['select state'];
                          districts = ['select district'];
                          localities = ['select locality'];
                          selState = 'select state';
                          selDistrict = 'select district';
                          selLocality = 'select locality';
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(75, 0, 130, 1),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.landscape,
                      color: Color.fromRGBO(75, 0, 130, 1),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: false,
                    fillColor: Colors.blueAccent[100],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //Select State
                DropdownButtonFormField(
                  value: selState,
                  style: textStyle,
                  hint: Text("select state"),
                  items: states.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selState = item as String;
                      if (selState == 'AndhraPradesh') {
                        setState(() {
                          districts = ['select district', 'Nellore', 'Kadapa'];
                        });
                      } else if (selState == 'select state') {
                        setState(() {
                          districts = ['select district'];
                          localities = ['select locality'];
                          selDistrict = 'select district';
                          selLocality = 'select locality';
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(75, 0, 130, 1),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.place,
                      color: Color.fromRGBO(75, 0, 130, 1),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: false,
                    fillColor: Colors.blueAccent[100],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //Select district
                DropdownButtonFormField(
                  value: selDistrict,
                  style: textStyle,
                  hint: Text('select district'),
                  items: districts.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selDistrict = item as String;
                      if (selDistrict == 'Nellore') {
                        localities = ['select locality', 'Atmakur'];
                        selLocality = 'select locality';
                      } else if (selDistrict == 'Kadapa') {
                        localities = ['select locality', 'Pulivendula'];
                        selLocality = 'select locality';
                      } else if (selDistrict == 'select district') {
                        setState(() {
                          localities = ['select locality'];
                          selLocality = 'select locality';
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(75, 0, 130, 1),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_city,
                      color: Color.fromRGBO(75, 0, 130, 1),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: false,
                    fillColor: Colors.blueAccent[100],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //select locality
                DropdownButtonFormField(
                  value: selLocality,
                  style: textStyle,
                  hint: Text("select locality"),
                  items: localities.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selLocality = item as String;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(75, 0, 130, 1),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.navigation,
                      color: Color.fromRGBO(75, 0, 130, 1),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: false,
                    fillColor: Colors.blueAccent[100],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                //search donars button
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 16,
                      shadowColor: Color.fromRGBO(75, 0, 130, 1),
                      primary: Colors.white,
                      minimumSize: Size.fromHeight(40),
                    ),
                    onPressed: () {
                      if (selLocality == 'select locality') {
                        //show error
                        Fluttertoast.showToast(msg: "select location");
                      } else {
                        var type = [];
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DonarsList(
                                  selLocality: selLocality,
                                )));
                      }
                    },
                    child: Text(
                      "SEARCH DONARS",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromRGBO(75, 0, 130, 1),
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "lib/images/pics/progress.png",
            fit: BoxFit.cover,
            height: 220,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Map is in under development",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
          )
        ],
      ),
    ];

    return isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset("lib/images/Loading.gif"),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Rakth Dhaan"),
              actions: [
                //requestsNotifications
                IconButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      DocumentSnapshot snapshot = await FirebaseFirestore
                          .instance
                          .collection("imageUsers")
                          .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
                          .get();

                      String town = snapshot["town"].toString();

                      print(DateTime.now());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Requests(town: town)));

                      setState(() {
                        isLoading = false;
                      });
                    },
                    icon: Icon(Icons.notifications)),
                //profile
                IconButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      DocumentSnapshot snapshot = await FirebaseFirestore
                          .instance
                          .collection("imageUsers")
                          .doc(widget.phone)
                          .get();

                      var name = snapshot["name"].toString();

                      var selected = snapshot["bloodgroup"].toString();
                      var selCountry = snapshot["country"].toString();
                      var selState = snapshot["state"].toString();
                      var selDistrict = snapshot["district"].toString();
                      var selLocality = snapshot["town"].toString();
                      var profilePic = snapshot["profilePic"];
                      String gender = snapshot["gender"].toString();

                      setState(() {
                        isLoading = false;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                gender: gender,
                                profilePic: profilePic,
                                phone: widget.phone,
                                name: name,
                                selected: selected,
                                selCountry: selCountry,
                                selState: selState,
                                selDistrict: selDistrict,
                                selLocality: selLocality)),
                      );
                    },
                    icon: Icon(Icons.person))
              ],
              backgroundColor: Color.fromRGBO(75, 0, 130, 1),
            ),

            drawer: Drawer(
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DrawerHeader(
                      margin: EdgeInsets.all(0),
                      decoration:
                          BoxDecoration(color: Color.fromRGBO(75, 0, 130, 1)

                              //   gradient: LinearGradient(
                              //   begin: Alignment.bottomRight,
                              //   end: Alignment.topLeft,
                              //   colors: [
                              //     Color.fromARGB(225, 234, 28, 28),
                              //     Color.fromARGB(255, 67, 203, 69),
                              //     Color.fromARGB(255, 173, 49, 121),
                              //     Color.fromARGB(255, 72, 210, 139),
                              //     Color.fromARGB(255, 0, 0, 0),
                              //     Color.fromARGB(255, 0, 255, 255)
                              //   ],
                              // )
                              ),
                      child: //photo
                          StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("imageUsers")
                            .where("phone", isEqualTo: widget.phone)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> userMap =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            radius: 55,
                                            backgroundColor: Colors.black,
                                            backgroundImage: NetworkImage(
                                                userMap["profilePic"]),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            userMap["name"],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return Text("no data");
                            }
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    ListTile(
                      tileColor: tileColor,
                      leading: Icon(
                        Icons.home,
                        color: iconColor,
                      ),
                      title: Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                    ),
                    ListTile(
                      tileColor: tileColor,
                      leading: Icon(
                        Icons.search,
                        color: Color.fromRGBO(75, 0, 130, 1),
                      ),
                      title: Text("Search",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                    ),
                    ListTile(
                      tileColor: tileColor,
                      leading: Icon(
                        Icons.map,
                        color: Color.fromRGBO(75, 0, 130, 1),
                      ),
                      title: Text("Map",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _currentIndex = 2;
                        });
                      },
                    ),
                    ListTile(
                      tileColor: tileColor,
                      leading: Icon(
                        Icons.request_quote,
                        color: Color.fromRGBO(75, 0, 130, 1),
                      ),
                      title: Text("My Requests",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        String phone = FirebaseAuth
                            .instance.currentUser!.phoneNumber as String;
                        print(phone);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MyRequests(
                                      phone: phone,
                                    )));
                      },
                    ),
                    ListTile(
                      tileColor: tileColor,
                      leading: Icon(
                        Icons.bloodtype,
                        color: Color.fromRGBO(75, 0, 130, 1),
                      ),
                      title: Text("DonateTo / ReceiveFrom",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => DonateOrReceive()),
                        );
                      },
                    ),
                    ListTile(
                      tileColor: tileColor,
                      leading: Icon(
                        Icons.feedback_rounded,
                        color: Color.fromRGBO(75, 0, 130, 1),
                      ),
                      title: Text(
                        "FeedBack",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Feedbacks()));
                      },
                    ),
                    ListTile(
                      tileColor: tileColor,
                      leading: Icon(
                        Icons.currency_rupee_sharp,
                        color: Color.fromRGBO(75, 0, 130, 1),
                      ),
                      title: Text("Donate Us",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => DonateUs()));
                      },
                    ),
                    Problem(),
                    ListTile(
                      tileColor: tileColor,
                      leading: Icon(
                        Icons.delete,
                        color: Color.fromRGBO(75, 0, 130, 1),
                      ),
                      title: Text("Delete Account",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () async {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          final phone = user.phoneNumber;
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => DeleteAccount(
                                      phone: phone,
                                    )),
                          );
                        }
                      },
                    ),
                    ListTile(
                      tileColor: tileColor,
                      leading: Icon(
                        Icons.question_answer,
                        color: Color.fromRGBO(75, 0, 130, 1),
                      ),
                      title: Text("FAQs",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => FAQ()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ignore: prefer_const_constructors
            body: Center(child: list[_currentIndex]),

            bottomNavigationBar: CurvedNavigationBar(
              index: _currentIndex,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Color.fromRGBO(75, 0, 130, 1),
              animationCurve: Curves.ease,
              color: Color.fromRGBO(75, 0, 130, 1),
              height: 60.0,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 40,
                ),
                Icon(
                  Icons.place,
                  color: Colors.white,
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          );
  }
}
