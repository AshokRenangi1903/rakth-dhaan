import 'package:firebaselearning/bdapp/updateProfile.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  var phone;
  var name;
  var selected;
  var selCountry;
  String gender;
  var selState;
  var selDistrict;
  var selLocality;
  var profilePic;
  Profile(
      {Key? key,
      required this.profilePic,
      required this.phone,
      required this.gender,
      required this.name,
      required this.selected,
      required this.selCountry,
      required this.selState,
      required this.selDistrict,
      required this.selLocality})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    String selected = widget.selected.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),

            //photo
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(widget.profilePic),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.name}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  '${widget.selected}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color.fromARGB(255, 182, 34, 23),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            //whole container
            Container(
              width: double.infinity,
              decoration: BoxDecoration(),
              margin: EdgeInsets.fromLTRB(30, 10, 40, 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //gender

                    Text(
                      "  Gender",
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 12, 20, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${widget.gender}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //country

                    Text(
                      "  Country",
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 12, 20, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${widget.selCountry}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //state

                    Text(
                      "  State",
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 12, 20, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${widget.selState}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //district

                    Text(
                      "  District",
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 12, 20, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${widget.selDistrict}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //locality

                    Text(
                      "  Locality",
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 12, 20, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${widget.selLocality}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
            ),

            //Change Profile Button
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  primary: Colors.black,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(color: Colors.black, width: 2),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateProfile(
                              phone: widget.phone,
                              name: widget.name,
                              selected: selected,
                              profilePic: widget.profilePic)));
                },
                child: Text(
                  "Change Profile",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
