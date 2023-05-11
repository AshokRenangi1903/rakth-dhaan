// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaselearning/bdapp/hmpg.dart';
import 'package:firebaselearning/bdapp/updateProfile.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RequestBlood extends StatefulWidget {
  var country, state, district, locality;
  RequestBlood(
      {Key? key,
      required this.country,
      required this.state,
      required this.district,
      required this.locality})
      : super(key: key);

  @override
  State<RequestBlood> createState() => _RequestBloodState();
}

File? requestPic;
bool check = false;
String imgPath = "";

var bloodGroups = ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'];
var selectedBG = "A+";
late String imageName = "not selected";

TextEditingController hAddController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController hospitalController = TextEditingController();
TextEditingController rewardController = TextEditingController();
String btnValue = "POST REQUEST";

class _RequestBloodState extends State<RequestBlood> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/images/pics/running.gif",
                  fit: BoxFit.cover,
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      ),
                    ),
                    Center(
                      child: Text("  Posting Request Please Wait..."),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Request Blood"),
              backgroundColor: Color.fromRGBO(75, 0, 130, 1),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Center(
                  child: Container(
                    width: 280,
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 0,
                          ),
                          // Text(
                          //   "Request For Blood",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 40,
                          //       color: Color.fromRGBO(75, 0, 130, 1)),
                          // ),

                          Image.asset(
                            "lib/images/pics/patient.png",
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                          // Icon(
                          //   Icons.bloodtype,
                          //   size: 160,
                          //   color: Colors.red,
                          // ),
                          SizedBox(
                            height: 0,
                          ),

                          //name of patient
                          TextFormField(
                            validator: (item) {
                              return item.toString().length >= 3 &&
                                      item.toString().length <= 25
                                  ? null
                                  : "name must be b/w 3 to 25 characters only";
                            },
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Patient's Name",
                              prefixIcon: Icon(
                                Icons.person,
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
                            height: 20,
                          ),

                          //Blood Group
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Blood Group :",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              DropdownButton(
                                  value: selectedBG,
                                  items: bg.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item),
                                      value: item,
                                    );
                                  }).toList(),
                                  onChanged: (item) {
                                    print('item is $item');
                                    setState(() {
                                      selectedBG = item as String;
                                    });
                                  }),
                            ],
                          ),

                          //Gender of Patient
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Gender :",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              DropdownButton(
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
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //Upload Image of Proof
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(75, 0, 130, 1),
                                minimumSize: Size.fromHeight(40),
                              ),
                              onPressed: () async {
                                final selectedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);

                                if (selectedImage != null) {
                                  File convertedFile = File(selectedImage.path);
                                  print("ok selected");
                                  print(selectedImage.name);
                                  setState(() {
                                    requestPic = convertedFile;
                                    check = true;
                                    imageName = selectedImage.name;
                                  });
                                } else {
                                  print("not selected");
                                  Fluttertoast.showToast(
                                      msg: "Image is required");
                                }
                              },
                              child: Text(
                                "Upload Image",
                                style: TextStyle(fontSize: 18),
                              )),
                          check ? Text(imageName) : Text("not selected"),
                          SizedBox(
                            height: 20,
                          ),

                          //Hospital Name
                          TextFormField(
                            validator: (item) {
                              return item.toString().length >= 3 &&
                                      item.toString().length <= 25
                                  ? null
                                  : "Give valid input";
                            },
                            controller: hospitalController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "enter hospital's name",
                              prefixIcon: Icon(
                                Icons.local_hospital,
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
                            // InputDecoration(
                            //   border: OutlineInputBorder(),
                            //   hintText: "enter hospital's name",
                            //   prefixIcon: Icon(
                            //     Icons.local_hospital,
                            //     color: Colors.blue,
                            //   ),
                            //   filled: true,
                            //   fillColor: Colors.blue[50],
                            //   label: Text("Hospital Name"),
                            //   labelStyle: TextStyle(color: Colors.blue),
                            //   focusedBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.blue)),
                            //   enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.blue)),
                            // ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //Hospital Address
                          TextFormField(
                            validator: (item) {
                              return item.toString().length >= 3 &&
                                      item.toString().length <= 25
                                  ? null
                                  : "Give Valid Input";
                            },
                            controller: hAddController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "enter hospital's address",
                              prefixIcon: Icon(
                                Icons.location_city_rounded,
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
                            // InputDecoration(
                            //   focusedBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.blue)),
                            //   enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.blue)),
                            //   hintText: "enter hospital's address",
                            //   prefixIcon: Icon(
                            //     Icons.place,
                            //     color: Colors.blue,
                            //   ),
                            //   label: Text("Hospital Address"),
                            //   labelStyle: TextStyle(color: Colors.blue),
                            //   filled: true,
                            //   fillColor: Colors.blue[50],
                            // ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //Post Request Button
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(75, 0, 130, 1),
                                minimumSize: Size.fromHeight(40),
                              ),
                              onPressed: () {
                                if (imageName != "not selected") {
                                  doit();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Prescription Image Required");
                                }
                              },
                              child: Text(
                                btnValue,
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Future<void> postIt() async {
    String phone = FirebaseAuth.instance.currentUser!.phoneNumber as String;
    setState(() {
      btnValue = "sending request....";
      isLoading = true;
    });

    String i = DateFormat('dd-MM-yyyy  KK:mm:ss a').format(DateTime.now());

    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("Requests")
        .child(phone + "_" + i)
        .putFile(requestPic!);

    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      imgPath = downloadUrl;
    });
    //storing the data into firebase
    Map<String, dynamic> requestor = {
      "name": nameController.text.toString(),
      "bloodgroup": selectedBG.toString(),
      "country": widget.country.toString(),
      "state": widget.state.toString(),
      "district": widget.district.toString(),
      "town": widget.locality.toString(),
      "hName": hospitalController.text.toString(),
      "Reward": rewardController.text.toString(),
      "gender": gender,
      "requestPic": downloadUrl,
      "phone": FirebaseAuth.instance.currentUser!.phoneNumber as String,
      "hAddress": hAddController.text.toString(),
      "time": i,
    };

    await FirebaseFirestore.instance
        .collection("AllRequests")
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber! + " Date:" + i)
        .set(requestor);

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("imageUsers")
        .where("town", isEqualTo: widget.locality.toString())
        .where("phone",
            isNotEqualTo:
                FirebaseAuth.instance.currentUser!.phoneNumber as String)
        .get();

    for (var doc in snapshot.docs) {
      if (doc["phone"] == phone) {
        Fluttertoast.showToast(msg: "going on");
      } else {
        var tokenUser = doc["token"].toString();
        Future<bool> pushNotificationsSpecificDevice({
          required String title,
          required String body,
          required String tokenUser,
        }) async {
          String dataNotifications = '{ "to" : "$tokenUser"'
              ' "data" : {'
              '"value":"request"'
              ' } '
              ' "notification" : {'
              ' "title":"$title",'
              '"body":"$body",'
              '"image":"$imgPath" '
              ' }'
              ' }';

          await http.post(
            Uri.parse(Constants.BASE_URL),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'key= ${Constants.KEY_SERVER}',
            },
            body: dataNotifications,
          );
          return true;
        }

        pushNotificationsSpecificDevice(
          title: nameController.text.toString(),
          body: hospitalController.text.toString(),
          tokenUser: tokenUser,
        );
      }
    }

    nameController.clear();
    hAddController.clear();
    hospitalController.clear();
    rewardController.clear();

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Hmpg(
                  phone: phone,
                )));

    Fluttertoast.showToast(msg: "request send");
    setState(() {
      btnValue = "POST REQUEST";
      isLoading = false;
    });
  }

  void doit() {
    if (formkey.currentState!.validate()) {
      postIt();
    } else {
      print("not working");
    }
  }
}

class Constants {
  static final String BASE_URL = 'https://fcm.googleapis.com/fcm/send';
  static final String KEY_SERVER =
      'AAAA8UaT2Tw:APA91bErBnLhEZUWA2eyThXh8MbfS656wIPf_no_t9XrRNP4q21oSqVYNVehJW6vVMXd6fPQFBSgNcexsmLDg3HAMKfdrLgxBh9czCkBtDxYNqNvym3dhLpgkA70PoBTpITKoaa_WyHU';
  static final String SENDER_ID = '1036271212860';
}
