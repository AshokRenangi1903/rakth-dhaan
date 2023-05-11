import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bdapp/reqImg.dart';

class NearByRequests extends StatefulWidget {
  String town;
  NearByRequests({Key? key, required this.town}) : super(key: key);

  @override
  State<NearByRequests> createState() => _NearByRequestsState();
}

class _NearByRequestsState extends State<NearByRequests> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   () async {
  //     DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //         .collection("imageUsers")
  //         .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
  //         .get();
  //     String town = snapshot["town"].toString();
  //     setState(() {
  //       String town = snapshot["town"].toString();
  //     });
  //   };
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("AllRequests")
          .where("town", isEqualTo: widget.town)
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> allRequests =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  return Column(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ReqImg(
                                        reqImg: allRequests["requestPic"],
                                      )));
                        },
                        child: Container(
                          height: 150,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          color: Color.fromRGBO(196, 128, 255, 0.7),
                          // child:
                          //     Image(image: NetworkImage(allRequests["requestPic"])),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //main column one
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Blood Group :  ${allRequests["bloodgroup"]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            allRequests["hName"],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                                "${allRequests["town"]}," +
                                                    allRequests["state"])),
                                        Expanded(
                                          child: Text(
                                            allRequests["phone"],
                                            style:
                                                TextStyle(color: Colors.white),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(allRequests["time"]),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Image(
                                            height: 90,
                                            image: NetworkImage(
                                                allRequests["requestPic"])),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                      )
                    ],
                  );
                });
          } else {
            return Text("no data");
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }
      },
    );
  }
}
