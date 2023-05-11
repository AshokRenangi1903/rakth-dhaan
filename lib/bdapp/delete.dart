import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/signup/page1.dart';

class DeleteAccount extends StatefulWidget {
  var phone;
  DeleteAccount({Key? key, required this.phone}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var phone = '${widget.phone}';
    return isLoading
        ? Scaffold(
            body: Center(
              child: Column(
                children: [
                  Image.asset("lib/images/load.gif"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("deleting your account..."),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(75, 0, 130, 1),
              title: Text("Delete My Account "),
            ),
            body: Column(children: [
              Image.asset(
                "lib/images/Inbox cleanup-rafiki.png",
                width: 280,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Do you really want to delete your account?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.deepPurple),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("NO")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        Fluttertoast.showToast(msg: "Account deleting .......");
                        await FirebaseAuth.instance.signOut();

                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const PageOne()),
                        );
                        final user = FirebaseAuth.instance.currentUser;
                        await FirebaseFirestore.instance
                            .collection("imageUsers")
                            .doc(phone)
                            .delete();
                        await FirebaseAuth.instance.currentUser!.delete();

                        Fluttertoast.showToast(
                            msg: "Account deleted succesfully");

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text("Yes")),
                ],
              )
            ]),
          );
  }
}
