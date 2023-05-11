// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/screens/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mobile extends StatefulWidget {
  const Mobile({Key? key}) : super(key: key);

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController phoneController = TextEditingController();

  // void sendotp() async {
  //   String phone = "+91" + phoneController.text.trim();

  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     codeSent: (verificationId, resendToken) {
  //       Navigator.push(
  //           context,
  //           CupertinoPageRoute(
  //               builder: (context) => OTP(verificationId: verificationId)));
  //     },
  //     verificationCompleted: (credential) {},
  //     verificationFailed: (ex) {
  //       print(ex.code.toString());
  //     },
  //     codeAutoRetrievalTimeout: (verificationId) {},
  //     timeout: Duration(seconds: 45),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(40),
            child: Column(children: [
              // ignore: prefer_const_constructors
              SizedBox(
                height: 40,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: phoneController,
                    validator: (item) {
                      return item.toString().length != 10
                          ? null
                          : 'mobile number must be 10 characters';
                    },
                    decoration: InputDecoration(
                      prefix: Text(
                        "+91 ",
                        style: TextStyle(color: Colors.black),
                      ),
                      hintText: 'enter mobile number',
                      border: OutlineInputBorder(),
                      label: Text('mobile'),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextButton(
                      onPressed: () {
                        // sendotp();
                      },
                      child: Text("send otp")),
                ],
              ))
            ]),
          ),
        ),
      ),
    );
  }
}
