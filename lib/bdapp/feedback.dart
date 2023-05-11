import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({Key? key}) : super(key: key);

  @override
  State<Feedbacks> createState() => _FeedbacksState();
}

TextEditingController fbController = TextEditingController();

class _FeedbacksState extends State<Feedbacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(
          "FeedBack 🙂 🙁",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "lib/images/Feedback-bro.png",
                height: 250,
              ),
              Text(
                "Give your valuable feedback that helps us to identify our mistakes and make it better.... ",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                maxLines: 10,
                cursorColor: Colors.black,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
                controller: fbController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  hintText: 'Enter your feedback..........',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(27, 10, 27, 10),
                        primary: Colors.deepPurple,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 16,
                        side: BorderSide(color: Colors.white, width: 3),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        submit();
                        Fluttertoast.showToast(
                            msg: "feedback submitted successfully");
                        fbController.clear();
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    String feedback = fbController.text.toString();
    var phone = FirebaseAuth.instance.currentUser!.phoneNumber;

    Map<String, dynamic> newUserData = {"feedback": feedback};

    await FirebaseFirestore.instance
        .collection("Feedback")
        .doc(phone)
        .set(newUserData);
  }
}
