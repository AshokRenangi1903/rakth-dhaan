// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'hmpg.dart';

class UpdateProfile extends StatefulWidget {
  var phone;
  String name, selected, profilePic;
  UpdateProfile(
      {Key? key,
      required this.profilePic,
      required this.phone,
      required this.name,
      required this.selected})
      : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

TextEditingController nameController = TextEditingController();
var bg = ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'];
var selected = "A+";

var genders = ["Male", "Female"];
var gender = "Male";
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
File? profilePic;
bool isLoading = false;

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name;
    setState(() {
      selected = widget.selected.toString();
    });
  }

  bool imgSel = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "lib/images/pics/running.gif",
                    width: 250,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.purple,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Plese wait your detials are being updated"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(75, 0, 130, 1),
              title: Text("Update ur profile"),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formkey,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          CupertinoButton(
                            onPressed: () async {
                              final selectedImage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);

                              if (selectedImage != null) {
                                File convertedFile = File(selectedImage.path);
                                setState(() {
                                  profilePic = convertedFile;
                                  imgSel = true;
                                });
                                print("ok selected");
                              } else {
                                print("not selected");
                                setState(() {
                                  imgSel = false;
                                });
                              }
                            },
                            child: CircleAvatar(
                              child: Text(
                                "tap to update profile ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              radius: 80,
                              backgroundColor: Color.fromRGBO(75, 0, 130, 50),
                              backgroundImage: (profilePic != null)
                                  ? FileImage(profilePic!)
                                  : null,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //name of user
                          TextFormField(
                            validator: (item) {
                              return item.toString().trim().length > 3 &&
                                      item.toString().length <= 25
                                  ? null
                                  : "name must be b/w 3 to 25 characters only";
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              label: Text("Name",
                                  style: TextStyle(
                                      color: Color.fromRGBO(75, 0, 130, 1))),
                              hintText: 'Enter Your Name',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(75, 0, 130, 1),
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              filled: false,
                              fillColor: Colors.white,
                              errorStyle: TextStyle(color: Colors.redAccent),
                            ),
                            cursorColor: Colors.black,
                            cursorWidth: 2,
                            cursorRadius: Radius.circular(3),
                            showCursor: true,
                            controller: nameController,
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //blood group
                          DropdownButtonFormField(
                            value: selected,
                            items: bg.map((item) {
                              return DropdownMenuItem(
                                child: Text(item),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (item) {
                              setState(() {
                                selected = item as String;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Color.fromRGBO(75, 0, 130, 1),
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.bloodtype,
                                color: Color.fromRGBO(75, 0, 130, 1),
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: false,
                              fillColor: Colors.blueAccent[100],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //gender
                          DropdownButtonFormField(
                            value: gender,
                            items: genders.map((item) {
                              return DropdownMenuItem(
                                child: Text(item),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (item) {
                              setState(() {
                                gender = item as String;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Color.fromRGBO(75, 0, 130, 1),
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.male,
                                color: Color.fromRGBO(75, 0, 130, 1),
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: false,
                              fillColor: Colors.blueAccent[100],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //country
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
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: false,
                              fillColor: Colors.blueAccent[100],
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
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: false,
                              fillColor: Colors.blueAccent[100],
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
                                  localities = [
                                    'select locality',
                                    'Pulivendula'
                                  ];
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
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: false,
                              fillColor: Colors.blueAccent[100],
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
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(75, 0, 130, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: false,
                              fillColor: Colors.blueAccent[100],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //Update button

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.fromLTRB(30, 2, 30, 2),
                                    primary: Color.fromRGBO(75, 0, 130, 1),
                                    elevation: 16),
                                onPressed: () {
                                  if (selLocality == 'select locality' ||
                                      imgSel == false) {
                                    Fluttertoast.showToast(
                                        msg: "Give image and location");
                                  } else if (_formkey.currentState!
                                      .validate()) {
                                    update();
                                  }
                                },
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
          );
  }

  void update() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      isLoading = true;
    });
    if (user != null) {
      final phone = user.phoneNumber as String;
      Hmpg(
        phone: phone,
      );

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("imageUsers")
          .child(phone)
          .putFile(profilePic!);

      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      String? token = await FirebaseMessaging.instance.getToken();
      Map<String, dynamic> updateUserData = {
        "name": nameController.text.trim(),
        "bloodgroup": selected.toString(),
        "token": token,
        "country": selCountry.toString(),
        "state": selState.toString(),
        "district": selDistrict.toString(),
        "town": selLocality.toString(),
        "profilePic": downloadUrl,
        "phone": phone,
        "gender": gender
      };
      await FirebaseFirestore.instance
          .collection("imageUsers")
          .doc(phone)
          .set(updateUserData);

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Hmpg(
                    phone: widget.phone,
                  )));
    }
    setState(() {
      isLoading = false;
    });
    Fluttertoast.showToast(msg: "Updated successfully");
  }
}
