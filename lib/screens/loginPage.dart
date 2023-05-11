import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearning/firebase_options.dart';
import 'package:firebaselearning/screens/home.dart';
import 'package:firebaselearning/screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: Scaffold(
              appBar: AppBar(title: Text("Login Page")),
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
                        child: Text("login")),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("register here")),
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
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((user) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
        Fluttertoast.showToast(msg: "logged in successfully");
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "error is:" + onError.toString());
      });
    }
  }
}
