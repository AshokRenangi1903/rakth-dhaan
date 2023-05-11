import 'package:flutter/material.dart';

class DonateUs extends StatelessWidget {
  const DonateUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donate Us"),
        backgroundColor: Color.fromRGBO(75, 0, 130, 1),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    boxShadow: [],
                    color: Color.fromRGBO(100, 20, 130, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    "lib/images/phonepay.jpg",
                  ))),
          SizedBox(
            height: 10,
          ),
          Text(
            "Scan and Help",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(75, 0, 130, 1),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Color.fromRGBO(100, 20, 130, 1),
                ),
                borderRadius: BorderRadius.circular(50)),
            child: Image.asset(
              "lib/images/donate.png",
              height: 60,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "Donate us to help the needy people . . .  Even one rupee from one person can be a meal for a person in need...",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
