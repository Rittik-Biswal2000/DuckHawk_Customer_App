import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_duckhawk/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email;
  String _password;
  String _name;
  String _phone;
  bool _isSeller=false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                      decoration: InputDecoration(hintText: 'Name'),
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      }),
                  TextField(
                      decoration: InputDecoration(hintText: 'Phone Number'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          if(value.length==10)
                          _phone = value;
                          else{
                            Fluttertoast.showToast(
                                msg: "Should be a 10 digit number",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1
                            );
                          }
                        });
                      }
                      ),
                  TextField(
                      decoration: InputDecoration(hintText: 'Email'),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      }),
                  SizedBox(height: 15.0),
                  TextField(
                      decoration: InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      }),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text('Sign Up'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _email, password: _password)
                          .then((signedInUser) {
                        //signedInUser.user.displayName=_name;

                        Firestore.instance.collection('/users').document(signedInUser.user.uid).setData({

                          'uid':signedInUser.user.uid,
                          'Email':signedInUser.user.email,
                          'Name':_name,
                          'Phone Number':_phone,
                          'isSeller':_isSeller,
                        });


                      }).catchError((e) {
                        print(e);
                      });
                    },
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text("Already have an account ? Login Here"),
                  )
                ],
              )),
        ));
  }
}