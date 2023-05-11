import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DonarsList extends StatefulWidget {
  String selLocality;
  DonarsList({
    Key? key,
    required this.selLocality,
  }) : super(key: key);

  @override
  State<DonarsList> createState() => _DonarsListState();
}

var selBG = [
  'A+',
  'B+',
  'AB+',
  'O+',
  'A-',
  'B-',
  'AB-',
  'O-',
];

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  elevation: 20,
  shadowColor: Colors.black,
  primary: Colors.white,
  side: BorderSide(color: Colors.deepPurple, width: 2),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);

class _DonarsListState extends State<DonarsList> {
  @override
  Widget build(BuildContext context) {
    String selLocality = '${widget.selLocality}';
    return Scaffold(
        appBar: AppBar(
          title: Text(selLocality + " ~ Donars"),
          shadowColor: Colors.deepPurple,
          backgroundColor: Colors.deepPurple,
        ),
        body: Row(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selBG = [
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-',
                          ];
                        });
                      },
                      style: buttonStyle,
                      child: Text(
                        "ALL",
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        setState(() {
                          selBG = ["A+"];
                        });
                        print(selBG);
                      },
                      child: Text(
                        "A+",
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        setState(() {
                          selBG = ["B+"];
                        });
                      },
                      child: Text(
                        "B+",
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        setState(() {
                          selBG = ["AB+"];
                        });
                      },
                      child: Text(
                        "AB+",
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        setState(() {
                          selBG = ["O+"];
                        });
                      },
                      child: Text(
                        "O+",
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        setState(() {
                          selBG = ["A-"];
                        });
                      },
                      child: Text(
                        "A-",
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        setState(() {
                          selBG = ["B-"];
                        });
                      },
                      child: Text(
                        "B-",
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        setState(() {
                          selBG = ["AB-"];
                        });
                      },
                      child: Text(
                        "AB-",
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        setState(() {
                          selBG = ["O-"];
                        });
                      },
                      child: Text(
                        "O-",
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ]),
            ),
            Show(
              selLocality: selLocality,
            ),
          ],
        ));
  }
}

class Show extends StatefulWidget {
  String selLocality;
  Show({Key? key, required this.selLocality}) : super(key: key);

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("imageUsers")
          .where("town", isEqualTo: '${widget.selLocality}')
          .where("gender", isEqualTo: "Male")
          .where("bloodgroup", whereIn: selBG)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> userMap = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;

                    return ListTile(
                      onTap: () {
                        Fluttertoast.showToast(msg: userMap["name"]);
                      },
                      tileColor: Colors.white,
                      title: Text(
                        userMap["name"],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.deepPurple,
                        backgroundImage: NetworkImage(userMap["profilePic"]),
                      ),
                      trailing: Text(
                        userMap["bloodgroup"],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 210, 28, 15)),
                      ),
                      subtitle: Text(
                        userMap["phone"],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                    );
                  }),
            );
          } else {
            return Text("no data");
          }
        } else {
          return Row(
            children: [
              SizedBox(
                width: 100,
              ),
              CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            ],
          );
        }
      },
    );
  }
}
