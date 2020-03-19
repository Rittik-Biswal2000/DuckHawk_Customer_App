import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_duckhawk/main.dart';
class account extends StatefulWidget {
  @override
  _accountState createState() => _accountState();
}
String name="hello";
String s="hi";
/*
DocumentReference ref;
  getUserDoc() async {
  print("hi");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

   FirebaseUser user = await _auth.currentUser();
  ref = _firestore.collection('users').document(user.uid);
  _firestore
      .collection("users").where("uid",isEqualTo:user.uid )
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    //snapshot.documents.forEach((f) => print('${f.data}}'));
    snapshot.documents.forEach((f) => s='${f.data}');
    print("s is "+ s);
  });
  return s;
}*/
class _accountState extends State<account> {
  String g = "ji";

  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;

  void initState() {
    super.initState();
    getUserDoc();
   // _getCurrentUser();

    //getUserDoc();

  }/*
  _getCurrentUser()async{
    _auth=FirebaseAuth.instance;
    mCurrentUser=await _auth.currentUser();
    print("Hello"+mCurrentUser.email.toString());
    name=mCurrentUser.email.toString();
    print(name+" 1");
    showDialog(
      context: context,
      builder: (_) => LogoutOverlay(),
    );
    @override
    Widget build(BuildContext context) {
      //getUserDoc();
      print(name+" 3");

      return Scaffold(
          appBar: AppBar(
            title: Text("Account"),
          ),
          body:
          Text(name+" 2")
      );
    }


  }*/

  DocumentReference ref;
  getUserDoc() async {
    print("hi");
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();
    ref = _firestore.collection('users').document(user.uid);
    _firestore
        .collection("users").where("uid", isEqualTo: user.uid)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      //snapshot.documents.forEach((f) => print('${f.data}}'));
      snapshot.documents.forEach((f) => s = '${f.data}');
      //print(s.length);
      //print(s.split(',')[0]);
      //print(s.split(',')[1]);
      //print(s.split(',')[2]);
      //print(s.split(',')[3]);
      //

      //print("s is " + s);
      showDialog(
        context: context,
        builder: (_) => build(context),
      );
      //g = s.toString();
    });

  }
  Future<bool> _onWillPop() async {
    for(int m=0;m<2;m++){
      Navigator.pop(context);
    }
  }

  @override

    Widget build(BuildContext context) {
      //getUserDoc();
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
        appBar: new AppBar(
        title: new Text("Account"),
    backgroundColor: Color(0xff104670),
    ),
        body: LogoutOverlay(),



      ),);
    }

}

class LogoutOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body:
       new Card(
         child: Text(s.split(',')[1]+"\n"+s.split(',')[2]+"\n"+s.split(',')[3]+"\n"+s.split(',')[4]),
       ),
      /*Container(
        child:
        Text(s.split(',')[1]+"\n"+s.split(',')[2]+"\n"+s.split(',')[3]+"\n"+s.split(',')[4]),
      ),*/

    );
    }
}
