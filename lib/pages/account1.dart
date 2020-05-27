import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/entry.dart';
import 'package:project_duckhawk/pages/Help.dart';
import 'package:project_duckhawk/pages/cart2.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/pages/myorders.dart';

import '../main.dart';
import 'edittable.dart';

class acc1 extends StatefulWidget {
  @override
  _acc1State createState() => _acc1State();
}

ProgressDialog pr;

class _acc1State extends State<acc1> {
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    pr.hide();
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Color(0xff104670),
          title: Text("My Account"),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () async {
                pr.show();
                await getcartData();
                pr.hide();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new cart2()));
              },
            ),
          ]
        //leading:new Text("hi"),

      ),
      bottomNavigationBar: new Container(
        padding: EdgeInsets.all(0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                icon: new Icon(Icons.shop),
                onPressed: () async {
                  //pr.show();
                  //await getData(null);
                  //pr.hide();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new HomePage(null)));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.search), onPressed: () async {}),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.account_box),
                  onPressed: () async {
                    pr.show();
                    await getuac();
                    pr.hide();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new acc1()));
                  }),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: new Icon(Icons.shopping_cart),
                onPressed: () async {
                  pr.show();
                  await getcartData();
                  pr.hide();
                  print("Time taken");
                  stime = s.elapsedMilliseconds;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new cart2()));
                },
              ),
            ),
            /*Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.share),
                  onPressed: () => _onClick('Button3')),
            ),*/
          ],
        ),
      ),
      body: Column(children: <Widget>[
        new Row(
          children: <Widget>[
            Expanded(
                child: new Container(
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
                                    new Text(
                                      "Name : " + udetails[0]["Name"],
                                      style: TextStyle(fontSize: 16.0),
                                    )
                                  ],
                                ),
                              ),
                              new Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: new Row(
                                      children: <Widget>[
                                        new Text(
                                            "Phone Number : " +
                                                udetails[0]["Phone Number"]
                                                    .toString(),
                                            style: TextStyle(fontSize: 16.0))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: new Row(
                                      children: <Widget>[
                                        new Text("Email : " + udetails[0]["Email"],
                                            style: TextStyle(fontSize: 16.0))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: new Row(
                                      children: <Widget>[
                                        new Text(
                                            "Seller : " +
                                                udetails[0]["isSeller"].toString(),
                                            style: TextStyle(fontSize: 16.0))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                )),
          ],
        ),
        new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  new RaisedButton(
                      onPressed: () async {
                        pr.show();
                        await getorderdetails();
                        pr.hide();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new myorders()));
                      },
                      child: new RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'My Orders',
                            style: GoogleFonts.portLligatSans(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff104670),
                            ),
                            children: [
                              /*
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xff104670), fontSize: 30),
            ),
         */
                            ]),
                      ))
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
                  new RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new help()));
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'HELP',
                          style: GoogleFonts.portLligatSans(
                            textStyle: Theme.of(context).textTheme.display1,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff104670),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: new Column(
                children: <Widget>[
                  new RaisedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pop(context);
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new MyApp()));*/
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Logout',
                            style: GoogleFonts.portLligatSans(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff104670),
                            ),
                            children: [
                              /*
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xff104670), fontSize: 30),
            ),
         */
                            ]),
                      ))
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
                  new RaisedButton(
                      onPressed: () async {
                        //await FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new edit()));
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Update Your Details',
                            style: GoogleFonts.portLligatSans(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff104670),
                            ),
                            children: [
                              /*
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xff104670), fontSize: 30),
            ),
         */
                            ]),
                      ))
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
