import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_duckhawk/src/welcomPage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:project_duckhawk/main.dart';

import 'myorders.dart';
class orderconfirm extends StatefulWidget {
  @override
  _orderconfirmState createState() => _orderconfirmState();
}

class _orderconfirmState extends State<orderconfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
                child: Center(
                  child:new Text("Congratulations",textAlign: TextAlign.center,style: TextStyle(fontSize: 32.0),),
                ),
                //child: new Text("Congratulations",textAlign: TextAlign.center,style: TextStyle(fontSize: 24.0),),
              ),
            ],
          ),

          SizedBox(height: 20.0),
          new Row(
            children: <Widget>[
              new Container(
                child:Center(
                  child: new Text("Order \n  Confirmed",textAlign: TextAlign.center,style: TextStyle(fontSize: 32.0),),
                ),

              ),
            ],
          ),
          SizedBox(height: 20.0),
          Divider(),
          SizedBox(height: 20.0),
          new Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new WelcomePage()));
                },
                child: Text(
                  "Continue Shopping",textAlign: TextAlign.center,style: TextStyle(fontSize: 32.0),
                ),
              )
            ],
          ),
          SizedBox(height: 20.0),
          new Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new myorders()));
                },
                child: Text(
                  "View Orders",textAlign: TextAlign.center,style: TextStyle(fontSize: 32.0),
                ),
              )
            ],
          ),
          SizedBox(height: 20.0),
          new Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                },
                child: Text(
                  "Cancel/Replace Order",textAlign: TextAlign.center,style: TextStyle(fontSize: 32.0),
                ),
              )
            ],
          ),
          SizedBox(height: 20.0),
          new Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage(null)));
                },
                child: Text(
                  "Exit",textAlign: TextAlign.center,style: TextStyle(fontSize: 32.0),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
