import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bdapp/reqImg.dart';

class MyRequests extends StatefulWidget {
  String phone;
  MyRequests({Key? key, required this.phone}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  String phone = FirebaseAuth.instance.currentUser!.phoneNumber as String;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(75, 0, 130, 1),
          title: Text("My Requests"),
          actions: [
            IconButton(
                onPressed: () async {
                  createAlertDialog(context);
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("AllRequests")
                  .where("phone", isEqualTo: phone)
                  .orderBy("time", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      // height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> allRequests =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;

                            return Column(
                              children: [
                                CupertinoButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ReqImg(
                                                  reqImg:
                                                      allRequests["requestPic"],
                                                )));
                                  },
                                  child: Container(
                                    height: 150,
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    color: Color.fromRGBO(196, 128, 255, 0.7),
                                    // child:
                                    //     Image(image: NetworkImage(allRequests["requestPic"])),

                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //main column one
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      allRequests["name"],
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "Blood Group :  ${allRequests["bloodgroup"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      allRequests["hName"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                          "${allRequests["town"]}," +
                                                              allRequests[
                                                                  "state"])),
                                                  Expanded(
                                                    child: Text(
                                                      allRequests["phone"],
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ),
                                        //image column
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(allRequests["time"]),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Image(
                                                      image: NetworkImage(
                                                          allRequests[
                                                              "requestPic"])),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 2,
                                )
                              ],
                            );
                          }),
                    );
                  } else {
                    return Text("no data");
                  }
                } else {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }

//showDialog
  createAlertDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        "Do you want to delete all of your Requests?",
        style: TextStyle(color: Colors.red),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("NO")),
        ElevatedButton(
            onPressed: () async {
              Fluttertoast.showToast(msg: "Deleting..");
              deleteRequests();
              Navigator.pop(context);
            },
            child: Text(
              "YES",
            ))
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  //deleteRequests
  deleteRequests() async {
    QuerySnapshot snapDel = await FirebaseFirestore.instance
        .collection("AllRequests")
        .where("phone",
            isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber as String)
        .get();

    for (var doc in snapDel.docs) {
      print(doc["time"]);

      String time = doc["time"];

      await FirebaseFirestore.instance
          .collection("AllRequests")
          .doc(phone + " Date:" + time)
          .delete();

      FirebaseStorage.instance
          .ref()
          .child("Requests")
          .child(phone + "_" + doc["time"])
          .delete();
    }
  }
}
