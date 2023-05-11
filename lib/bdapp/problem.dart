import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/screens/signup/page1.dart';
import 'package:flutter/material.dart';

class Problem extends StatefulWidget {
  const Problem({Key? key}) : super(key: key);

  @override
  State<Problem> createState() => _ProblemState();
}

class _ProblemState extends State<Problem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.sync_problem,
        color: Color.fromRGBO(75, 0, 130, 1),
      ),
      title: Text("Having Problem",
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
      onTap: () async {
        shiftPage();
      },
    );
  }

  shiftPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ProblemPage()));
  }
}

//Another Page====>>> ProblemPage

class ProblemPage extends StatefulWidget {
  const ProblemPage({Key? key}) : super(key: key);

  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(75, 0, 130, 1),
        title: Text("Having Problem"),
        // ignore: prefer_const_constructors

        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              goToLogin();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Column(
            children: [
              Center(child: Image.asset("lib/images/problem.png")),
              Text(
                "If You are facing any problem like no name appered under the profile photo and taking long time for deleting the account..",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.red),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.red[50],
                child: Column(
                  children: [
                    Text(
                      "Follow this step to avoid it..",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Click the sign out icon at top right and then relogin again..",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  goToLogin() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PageOne()),
    );
  }
}
