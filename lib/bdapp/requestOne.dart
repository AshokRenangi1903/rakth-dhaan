import 'package:firebaselearning/bdapp/requestBlood.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RequestOne extends StatefulWidget {
  const RequestOne({Key? key}) : super(key: key);

  @override
  State<RequestOne> createState() => _RequestOneState();
}

var countries = ['select country', 'India'];
var selCountry = 'select country';

var states = ['select state'];
var selState = 'select state';

var districts = ['select district'];
var selDistrict = 'select district';

var localities = [
  'select locality',
];
var selLocality = 'select locality';

class _RequestOneState extends State<RequestOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(
            "Request For Blood",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Color.fromRGBO(75, 0, 130, 1),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                // Current Location of Patient
                Text(
                  "Give the Current Location Of The Patient",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),

                Image.asset(
                  "lib/images/pics/hospital.png",
                  fit: BoxFit.cover,
                  height: 220,
                ),

                // Image.asset(
                //   "lib/images/location.png",
                //   height: 180,
                // ),

                //Country
                DropdownButtonFormField(
                  value: selCountry,
                  items: countries.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selCountry = item as String;
                    });
                    setState(() {
                      if (selCountry == 'India') {
                        setState(() {
                          states = ['select state', 'AndhraPradesh'];
                        });
                      } else if (selCountry == 'select country') {
                        setState(() {
                          states = ['select state'];
                          districts = ['select district'];
                          localities = ['select locality'];
                          selState = 'select state';
                          selDistrict = 'select district';
                          selLocality = 'select locality';
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(75, 0, 130, 1),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.landscape,
                      color: Color.fromRGBO(75, 0, 130, 1),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    filled: false,
                    fillColor: Colors.purpleAccent[100],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //state
                DropdownButtonFormField(
                  value: selState,
                  hint: Text("select state"),
                  items: states.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selState = item as String;
                      if (selState == 'AndhraPradesh') {
                        setState(() {
                          districts = ['select district', 'Nellore', 'Kadapa'];
                        });
                      } else if (selState == 'select state') {
                        setState(() {
                          districts = ['select district'];
                          localities = ['select locality'];
                          selDistrict = 'select district';
                          selLocality = 'select locality';
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(75, 0, 130, 1),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.place,
                      color: Color.fromRGBO(75, 0, 130, 1),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    filled: false,
                    fillColor: Colors.purpleAccent[100],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //district
                DropdownButtonFormField(
                  value: selDistrict,
                  hint: Text('select district'),
                  items: districts.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selDistrict = item as String;
                      if (selDistrict == 'Nellore') {
                        localities = ['select locality', 'Atmakur'];
                        selLocality = 'select locality';
                      } else if (selDistrict == 'Kadapa') {
                        localities = ['select locality', 'Pulivendula'];
                        selLocality = 'select locality';
                      } else if (selDistrict == 'select district') {
                        setState(() {
                          localities = ['select locality'];
                          selLocality = 'select locality';
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(75, 0, 130, 1),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_city,
                      color: Color.fromRGBO(75, 0, 130, 1),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    filled: false,
                    fillColor: Colors.purpleAccent[100],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //locality
                DropdownButtonFormField(
                  value: selLocality,
                  hint: Text("select locality"),
                  items: localities.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selLocality = item as String;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromRGBO(75, 0, 130, 1),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.navigation,
                      color: Color.fromRGBO(75, 0, 130, 1),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(75, 0, 130, 1), width: 3),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    filled: false,
                    fillColor: Colors.purpleAccent[100],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 16,
                            primary: Color.fromRGBO(75, 0, 130, 1),
                            padding: EdgeInsets.fromLTRB(35, 10, 35, 10)),
                        onPressed: () {
                          if (selLocality == 'select locality') {
                            //show error
                            Fluttertoast.showToast(msg: "select location");
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RequestBlood(
                                        country: selCountry,
                                        state: selState,
                                        district: selDistrict,
                                        locality: selLocality)));
                          }
                        },
                        child: Text(
                          "Next :):",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
