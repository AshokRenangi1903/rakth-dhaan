// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/screens/signup/page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  var bg = ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'];
  var selected = 'A+';
  var genders = ['Male', 'Female'];
  var gender = 'Male';

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bloodgroupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                color: Colors.white,
                // decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //   begin: Alignment.bottomRight,
                //   stops: [0, 0.2, 0.5, 1],
                //   end: Alignment.topLeft,
                //   colors: [
                //     Color.fromARGB(225, 234, 28, 28),
                //     Color.fromARGB(255, 255, 255, 255),
                //     Color.fromARGB(0, 255, 255, 255),
                //     Color.fromARGB(255, 0, 255, 255)
                //   ],
                // )),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(40),
                    child: Column(children: [
                      Image.asset(
                        "lib/images/pics/login1.png",
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 0,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            //name of user

                            TextFormField(
                              validator: (item) {
                                return item.toString().length >= 3 &&
                                        item.toString().length <= 25
                                    ? null
                                    : "name must be b/w 3 to 25 characters only";
                              },
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              controller: nameController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Name',
                                hintStyle: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(27),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(27)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(27)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(27)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle: TextStyle(color: Colors.redAccent),
                              ),
                              cursorColor: Colors.black,
                              cursorWidth: 2,
                              cursorRadius: Radius.circular(3),
                              showCursor: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            //phone number of the user

                            TextFormField(
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.deepPurple),
                              validator: (item) {
                                return item.toString().length == 10
                                    ? null
                                    : "enter valid mobile number ";
                              },
                              textAlign: TextAlign.center,
                              controller: phoneController,
                              decoration: InputDecoration(
                                prefix: Text(" +91 |"),
                                hintText: 'Enter Mobile Number',
                                hintStyle: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(27),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(27)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(27)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(27)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle: TextStyle(color: Colors.redAccent),
                              ),
                              cursorColor: Colors.black,
                              cursorWidth: 2,
                              cursorRadius: Radius.circular(3),
                              showCursor: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 10,
                            ),
                            SizedBox(
                              height: 0,
                            ),

                            //gender
                            DropdownButtonFormField(
                                value: gender,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.male,
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 5),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 175, 91, 189),
                                ),
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
                            SizedBox(
                              height: 10,
                            ),
                            //blood group
                            DropdownButtonFormField(
                                value: selected,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                iconEnabledColor: Colors.white,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.bloodtype,
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 5),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 175, 91, 189),
                                ),
                                items: bg.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item),
                                    value: item,
                                  );
                                }).toList(),
                                onChanged: (item) {
                                  print('item is $item');
                                  setState(() {
                                    selected = item as String;
                                  });
                                }),
                            SizedBox(
                              height: 20,
                            ),

                            //Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.fromLTRB(27, 10, 27, 10),
                                      primary:
                                          Color.fromARGB(255, 245, 245, 245),
                                      shadowColor: Colors.purple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      elevation: 16,
                                      side: BorderSide(
                                          color: Colors.purple, width: 2),
                                    ),
                                    onPressed: () {
                                      next();
                                    },
                                    child: Text(
                                      "NEXT",
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          );
  }

  Future<void> next() async {
    if (_formkey.currentState!.validate()) {
      String phone = phoneController.text.trim();
      String name = nameController.text.trim();
      String bloodgroup = selected;

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PageTwo(
              phone: phone,
              name: name,
              bloodgroup: bloodgroup,
              gender: gender)));
    }
  }
}

Color? myColor = Colors.black;
