// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaselearning/bdapp/hmpg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTP extends StatefulWidget {
  final String verificationId,
      name,
      gender,
      phone,
      bloodgroup,
      country,
      state,
      district,
      locality;
  const OTP(
      {Key? key,
      required this.verificationId,
      required this.name,
      required this.phone,
      required this.gender,
      required this.bloodgroup,
      required this.country,
      required this.state,
      required this.district,
      required this.locality})
      : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  bool isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset("lib/images/load.gif"),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Verify OTP..."),
              backgroundColor: Color.fromRGBO(75, 0, 130, 1),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(40),
                  child: Column(children: [
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      "lib/images/pics/otp.png",
                      fit: BoxFit.cover,
                      height: 280,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                              color: Colors.deepPurple,
                              letterSpacing: 5,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          keyboardType: TextInputType.phone,
                          validator: (item) {
                            return item.toString().length == 10
                                ? null
                                : "enter valid mobile number ";
                          },
                          textAlign: TextAlign.center,
                          controller: _otp,
                          decoration: InputDecoration(
                            hintText: 'Enter Otp Number',
                            hintStyle: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(27),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(27)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(27)),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(27)),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: TextStyle(color: Colors.redAccent),
                          ),
                          cursorColor: Colors.black,
                          cursorWidth: 2,
                          cursorRadius: Radius.circular(3),
                          showCursor: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 6,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(27, 10, 27, 10),
                              primary: Color.fromARGB(255, 245, 245, 245),
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 16,
                              side: BorderSide(
                                  color: Colors.deepPurple, width: 2),
                            ),
                            onPressed: () {
                              add();
                              signup();
                            },
                            child: Text(
                              "Verify...",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ))
                  ]),
                ),
              ),
            ),
          );
  }

  void add() async {
    setState(() {
      isLoading = true;
    });
    String name = '${widget.name}';
    String phone = "+91" + '${widget.phone}';
    String bloodgroup = '${widget.bloodgroup}';
    String country = '${widget.country}';
    String state = '${widget.state}';
    String district = '${widget.district}';
    String locality = '${widget.locality}';
    String gender = widget.gender.toString();

    String? token = await FirebaseMessaging.instance.getToken();

    Map<String, dynamic> newUserData = {
      "name": name,
      "phone": phone,
      "bloodgroup": bloodgroup,
      "country": country,
      "token": token,
      "state": state,
      "district": district,
      "town": locality,
      "gender": gender,
      "profilePic":
          "https://www.seekpng.com/png/detail/413-4139803_unknown-profile-profile-picture-unknown.png"
    };

    await FirebaseFirestore.instance
        .collection("imageUsers")
        .doc(phone)
        .set(newUserData);
  }

  void signup() async {
    String phone = "+91" + '${widget.phone}';

    String otp = _otp.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);

        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (context) => Hmpg(
                    phone: phone,
                  )),
        );
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }

    setState(() {
      isLoading = false;
    });
  }
}
