import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/firebase_options.dart';
import 'package:firebaselearning/screens/home.dart';
import 'package:firebaselearning/screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegDup extends StatefulWidget {
  const RegDup({Key? key}) : super(key: key);

  @override
  State<RegDup> createState() => _RegDupState();
}

class _RegDupState extends State<RegDup> {
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Container(
            child: Scaffold(
              appBar: AppBar(title: Text("Register")),
              body: Container(
                margin: EdgeInsets.all(30),
                child: Form(
                  key: _formkey,
                  child: Column(children: [
                    TextFormField(
                      validator: (item) {
                        return item!.contains("@")
                            ? null
                            : 'enter valid mail id';
                      },
                      controller: _email,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: 'enter email',
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _password,
                      validator: (item) {
                        return item!.length > 5
                            ? null
                            : 'must be more than 5 characters';
                      },
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: 'enter password here',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          doit();
                        },
                        child: Text("register")),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          },
                          child: Text("login here")),
                    ),
                  ]),
                ),
              ),
            ),
          );
  }

  void doit() async {
    if (_formkey.currentState!.validate()) {
      final email = _email.text;
      final password = _password.text;

      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((user) {
        setState(() {
          isLoading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        Fluttertoast.showToast(msg: "registered successfully");
        Fluttertoast.showToast(msg: "now you can login");
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "error is:" + onError.toString());
      });
    }
  }
}
