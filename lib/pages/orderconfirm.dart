import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class orderconfirm extends StatefulWidget {
  @override
  _orderconfirmState createState() => _orderconfirmState();
}
getu()async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user = await _auth.currentUser();
  var firestore = Firestore.instance;
  firestore.collection('users').document(user.uid).collection('cart').getDocuments().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.documents) {
      ds.reference.delete();
    }
    });




/*  QuerySnapshot qn = await firestore.collection('users').document(user.uid)
      .collection('cart').getDocuments()
      .then((snapshot) {
    snapshot.documents.forEach((f) => l.add('${f.data}'));
    u=snapshot.documents;
  });*/
}
class _orderconfirmState extends State<orderconfirm> {

  @override
  void initState() {
    // TODO: implement initState
    getu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff104670),
        title: Text("Order"),
      ),
      body:
        new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  child: new Text("Congratulations"),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Container(
                  child: new Text("Order Confirmed"),
                ),
              ],
            ),
            Divider(),
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Continue Shopping",
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                  },
                  child: Text(
                    "View Order Summary",
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Cancel or Replace Order",
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Track Order",
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Exit",
                  ),
                )
              ],
            ),
          ],
        ),
    );
  }
}
