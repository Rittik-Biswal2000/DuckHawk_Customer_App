import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/signup.dart';
import 'package:project_duckhawk/src/welcomPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
Future<DocumentReference> getUserDoc() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  FirebaseUser user = await _auth.currentUser();/*
    DocumentReference ref = _firestore.collection('users').document(user.uid);
    print('Yahoo');
    print(ref.documentID);
    print(ref.firestore.collection('users').where(user.));
    return ref;*/



}
class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
@override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
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
                      decoration: InputDecoration(hintText: 'Email'),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      }),
                  SizedBox(height: 15.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Password'),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text('Login'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((user){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WelcomePage()),
                        );
                      }).catchError((e) {});
                    },
                  ),
                  SizedBox(height: 15.0),
                  Text('Don\'t have an account?'),
                  SizedBox(height: 10.0),
                  FlatButton(
                    child: Text('Sign Up'),

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                  ),
                 /* FlatButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => loaddata()),
                      );
                    },
                    child: Text("Click Me"),
                  )*/
                ],
              )),
        ));
  }

  Future<DocumentReference> getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();/*
    DocumentReference ref = _firestore.collection('users').document(user.uid);
    print('Yahoo');
    print(ref.documentID);
    print(ref.firestore.collection('users').where(user.));
    return ref;*/



  }
}