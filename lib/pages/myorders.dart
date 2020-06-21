import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/cart2.dart';
import 'package:project_duckhawk/pages/categories.dart';
import 'package:project_duckhawk/pages/item_info.dart';

import 'account1.dart';
import 'odetails.dart';
class myorders extends StatefulWidget {
  @override
  _myordersState createState() => _myordersState();
}
ProgressDialog pr;
class _myordersState extends State<myorders> {
  List<EachOrder> allorders = [];
  @override
  void initState() {
    getod();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xff104670),
        title: new Text("My Orders"),
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
                onPressed: () async{
                  //pr.show();
                  //await getData(null);
                  //pr.hide();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage(null)));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.search),
                  onPressed: () async {

                  }),
            ),
            Expanded(
              flex: 1,
              child: IconButton (
                  icon: new Icon(Icons.account_box),
                  onPressed: () async{
                    pr.show();
                    await getuac();
                    pr.hide();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>new acc1()));
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
                  stime=s.elapsedMilliseconds;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart2()));
                },),
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
      body:
      allorders.isEmpty?
          Container(
            child: Center(
              child: new Text("Loading..."),
            ),
          ):
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Column(
              children: allorders
                  .map(
                    (p) =>
                new Card(
                  child: SingleChildScrollView(
                      child:InkWell(
                        child: ListTile(

                          leading:
                          new Image.network("https://duckhawk.in/icon.jpeg"),

                          title:new Text("Address : ",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                          subtitle: new Column(
                            children: <Widget>[
                              new Container(
                                alignment: Alignment.topLeft,

                                child: Padding(
                                    padding: EdgeInsets.all(8.0),

                                    child:new Text("Total : ₹"+p.total,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                /*alignment: Alignment.topLeft,
                          child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                              ),
                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),



                                    child:new Text("Name : "+p.n,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),
                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),



                                    child:new Text("Contact : "+p.pn,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),
                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),



                                    child:new Text("Time : "+p.time,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),
                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),



                                    child:new Text("Order id : "+p.oid,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),


                             /* new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: new RaisedButton(
                                    child: Text("Location"),
                                    onPressed: (){
                                      launchMap(p.l['lat'].toString(), p.l['lng'].toString());
                                    },
                                  ),

                                  //http://maps.google.com/maps?q=24.197611,120.780512
                                  //child:new Text("Loc : "+p.l['lat'].toString()+" "+p.l['lng'].toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)



                                  //child:new Text("Latitudes : "+p.l['lat'].toString()+" "+p.l['lng'].toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),*/


                            ],
                          ),

                        ),
                        onTap: (){
                          print("key is :");
                          //print(sk);
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => new odetails(p.oid)));



                        },
                      )
                  ),
                ),

              )
                  .toList()))
    );
  }

  getod() async {
    oid.clear();
    ucat.clear();
    uquantity.clear();
    uprice.clear();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('orders')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => oid.add(f.documentID));
    });
    print("oid are :");
    for (var i = 0; i < oid.length; i++) {
      String link = "https://duckhawk-1699a.firebaseio.com/Orders/" +
          loc +
          "/" +
          oid[i] +
          ".json";
      print(link);
      final r = await http.get(link);
      if (r.statusCode == 200) {
        LinkedHashMap<String, dynamic> data1 = jsonDecode(r.body);
        EachOrder eachOrder = new EachOrder(
          data1["Address"].toString(),
          data1["time"].toString(),
          data1["total"].toString(),
          data1["Name"].toString(),
          data1["Phone_Number"].toString(),
          oid[i]

        );
        setState(() {
          allorders.add(eachOrder);
        });
        //address = data1['Address'];
        //t = data1['time'];
        //tot = data1['total'];
        String link1 = "https://duckhawk-1699a.firebaseio.com/Orders/" +
            loc +
            "/" +
            oid[i] +
            "/Products" +
            ".json";
        print(link1);
        final re = await http.get(link1);
        if (re.statusCode == 200) {
          LinkedHashMap<String, dynamic> data2 = jsonDecode(re.body);
          List d = data2.values.toList();
          List keys = data2.keys.toList();
          int k = 0;
          int leng = d.length;
          while (k < leng) {
            LinkedHashMap<String, dynamic> data3 = jsonDecode(re.body)[keys[k]];
            //print(data3["ProductId"]);
           /* ucat.add(data3['category']);
            uprice.add(data3['price']);
            uquantity.add(data3['quantity']);*/



            k++;
          }
        }
      }
    }
  }
}
class EachOrder {
  String add, time, total,n,pn,oid;
  var p,l;
  EachOrder(this.add, this.time,this.total,this.n,this.pn,this.oid);
}