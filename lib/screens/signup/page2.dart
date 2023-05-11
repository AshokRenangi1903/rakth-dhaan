// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../otp.dart';

class PageTwo extends StatefulWidget {
  const PageTwo(
      {Key? key,
      required this.phone,
      required this.gender,
      required this.name,
      required this.bloodgroup})
      : super(key: key);
  final String phone, name, bloodgroup, gender;
  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  TextEditingController countryController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController districtController = new TextEditingController();
  TextEditingController townController = new TextEditingController();

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

  bool isLoading = false;
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
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "lib/images/location.png",
                  fit: BoxFit.cover,
                  height: 250,
                ),
                Center(
                  child: Container(
                    width: 250,
                    child: Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
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
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.landscape,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            filled: true,
                            fillColor: Colors.purpleAccent[100],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                                  districts = [
                                    'select district',
                                    'Nellore',
                                    'Kadapa'
                                  ];
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
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.place,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            filled: true,
                            fillColor: Colors.purpleAccent[100],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            filled: true,
                            fillColor: Colors.purpleAccent[100],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.navigation,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            filled: true,
                            fillColor: Colors.purpleAccent[100],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                elevation: 10,
                                side: BorderSide(
                                    color: Colors.deepPurple, width: 3)),
                            onPressed: () {
                              if (selLocality == 'select locality') {
                                Fluttertoast.showToast(
                                    msg: "select exact location");
                              } else {
                                sendotp();
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.deepPurple,
                              ),
                            )),
                      ],
                    )),
                  ),
                ),
              ]),
            ),
          );
  }

  void sendotp() async {
    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + '${widget.phone}',
      codeSent: (verificationId, resendToken) {
        String name = '${widget.name}';
        String bloodgroup = '${widget.bloodgroup}';
        String phone = '${widget.phone}';
        String country = selCountry.toString().trim();
        String state = selState.toString().trim();
        String district = selDistrict.toString().trim();
        String locality = selLocality.toString().trim();
        String gender = widget.gender.toString();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTP(
                    verificationId: verificationId,
                    name: name,
                    bloodgroup: bloodgroup,
                    phone: phone,
                    country: country,
                    state: state,
                    gender: gender,
                    district: district,
                    locality: locality))).then((value) {
          setState(() {
            isLoading = false;
          });
        });
      },
      verificationCompleted: (credential) {},
      verificationFailed: (ex) {
        print(ex.code.toString());
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: Duration(seconds: 60),
    );
  }
}
