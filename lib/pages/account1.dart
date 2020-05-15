import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_duckhawk/entry.dart';
import 'package:project_duckhawk/pages/Help.dart';
import 'package:project_duckhawk/pages/myorders.dart';

import '../main.dart';
import 'edittable.dart';
class acc1 extends StatefulWidget {
  @override
  _acc1State createState() => _acc1State();
}

class _acc1State extends State<acc1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Account Details"),
      ),
      body:
        Column(
          children: <Widget>[
            new Row(

              children: <Widget>[
                Center(
                  child: new Card(

                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Container(
                          child: new Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: new Row(
                                  children: <Widget>[
                                    new Text("Name : "+udetails[0]["Name"],style: TextStyle(fontSize: 16.0),)
                                  ],
                                ),
                              ),
                              new Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: new Row(
                                      children: <Widget>[
                                        new Text("Phone Number : "+udetails[0]["Phone Number"],style:TextStyle(fontSize: 16.0))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: new Row(
                                      children: <Widget>[
                                        new Text("Email : "+udetails[0]["Email"],style:TextStyle(fontSize: 16.0))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: new Row(
                                      children: <Widget>[
                                        new Text("Seller : "+udetails[0]["isSeller"].toString(),style:TextStyle(fontSize: 16.0))
                                      ],
                                    ),
                                  ),




                                ],
                              ),


                            ],
                          ),


                        ),
                      )
                  ),
                ),

              ],

              ),
            new Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Row(
                    children: <Widget>[
                      new FlatButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new myorders()));
                      }, child: new Text("My Orders",style: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),color: Colors.amberAccent,)

                    ],
                  ),
                ),


              ],
            ),
            new Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Row(
                    children: <Widget>[
                      new RaisedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new help()));
                      }, child: new Text("Help",style: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),color: Colors.red,)

                    ],
                  ),
                ),


              ],
            ),
            new Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Row(
                    children: <Widget>[
                      new RaisedButton(onPressed: ()async{
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyApp()));
                      }, child: new Text("Logout",style: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),color: Colors.greenAccent,)

                    ],
                  ),
                ),


              ],
            ),
            new Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Row(
                    children: <Widget>[
                      new RaisedButton(onPressed: ()async{
                        //await FirebaseAuth.instance.signOut();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new edit()));
                      }, child: new Text("Update user details",style: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),color: Colors.greenAccent,)

                    ],
                  ),
                ),


              ],
            ),
      ]

        ),

    );
  }
}
