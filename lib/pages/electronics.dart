import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/pages/account1.dart';
import 'package:project_duckhawk/pages/ageverify.dart';
import 'package:http/http.dart' as http;

import 'package:project_duckhawk/pages/cart2.dart';

import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/categories.dart';
import 'package:project_duckhawk/src/loginPage.dart';
//import 'package:project_duckhawk/src/welcomPage.dart';

class e extends StatefulWidget {
  String s;
  String pi;

  e(this.s,this.pi);
  @override
  _eState createState() => _eState();
}

String a, b, c, d, f, g;
List li = [];
ProgressDialog pr;
class EachProduct {
  String name, des, q, img, p, id,cat;
  EachProduct(this.name, this.des, this.q, this.img, this.p, this.id, this.cat);
}

class _eState extends State<e> {
  List<EachProduct> allProduct = [];
  @override
  void initState() {
    getproductdetailsNew(widget.pi);
    super.initState();
  }
  getproductdetailsNew(String id) async {
    print(id);
    imgurl1.clear();
    quantity1.clear();
    price1.clear();
    name1.clear();
    description1.clear();
    prod_id2.clear();
    prod_cat2.clear();
    String link = "https://duckhawk-1699a.firebaseio.com/Seller/" +
        loc +
        "/" +
        id +
        "/products.json";
    final resource = await http.get(link);
    print("link is :");
    print(id);
    print(link);
    print(resource.body);
    pro = resource.body;
    //print(pro);
    if (pro.toString() == null) {
      print("hi");
    }

    if (resource.body != null) {
      if (resource.statusCode == 200) {
        LinkedHashMap<String, dynamic> data1 = jsonDecode(resource.body);
        //print("length is :");
        //print(data1.length);
        if (data1 != null) {
          List k = data1.keys.toList();

          print(k);
          List d = data1.values.toList();

          int h = 0;
          len1 = d.length;
          while (h < d.length) {
            LinkedHashMap<String, dynamic> data2 =
            jsonDecode(resource.body)[k[h]];
            //List x=data2.values.toList();
            //print(data2["cat"]);
            prod_id2.add(k[h]);
            prod_cat2.add(data2["cat"]);
            //badd


            String link2 = "https://duckhawk-1699a.firebaseio.com/Products/" + loc + "/" + data2["cat"] + "/" + k[h] + ".json";
            final resource3 = await http.get(link2);
            if (resource3.statusCode == 200) {
              LinkedHashMap<String, dynamic> data4 = jsonDecode(resource3.body);
              // print("city is:");

              EachProduct eachProduct = new EachProduct(
                  data4["ProductName"],
                  data4["ProductDesc"],
                  data4["stock"],
                  data4["Product_Image"],
                  data4["price"],
                  k[h],
              data2["cat"]);

              setState(() {
                allProduct.add(eachProduct);
              });

              quantity1.add(data4["stock"]);
              price1.add(data4["price"]);
              name1.add(data4["ProductName"]);
              description1.add(data4["ProductDesc"]);
              if (data4["Product_Image"] == null) {
                imgurl1.add("https://duckhawk.in/icon.jpeg");
              } else {
                imgurl1.add(data4["Product_Image"]);
              }
            }
            h++;
          }
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');

    Widget _title() {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Duckhawk',
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
      );
    }

    Widget _title1() {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Currently No shop available!',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xff104670),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Color(0xff104670),
          title: Text("Products"),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () async {
                pr.show();
                FirebaseUser user = await FirebaseAuth.instance.currentUser();
                pr.hide();
                if (user == null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new lp()));
                } else {
                  pr.show();
                  await getcartData();
                  pr.hide();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new cart2()));
                }
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
                    FirebaseUser user =
                        await FirebaseAuth.instance.currentUser();
                    print(user);
                    pr.hide();
                    if (user == null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => new lp()));
                    } else {
                      pr.show();
                      await getuac();
                      pr.hide();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => new acc1()));
                    }
                  }),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: new Icon(Icons.shopping_cart),
                onPressed: () async {
                  pr.show();
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  pr.hide();
                  if (user == null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new lp()));
                  } else {
                    pr.show();
                    await getcartData();
                    pr.hide();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new cart2()));
                  }
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
      body:
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Column(
              children: allProduct
                  .map(
                    (p) =>
                   new Card(
              child: SingleChildScrollView(
              child:InkWell(
              child: ListTile(

              leading:
              new Image.network((p.img==null)?"https://duckhawk.in/icon.jpeg":p.img,width:100.0,height:400.0),

            title:new Text(p.name),
            subtitle: new Column(
              children: <Widget>[
                new Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.all(8.0),

                      child:new Text("Price : ₹"+p.p,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                  ),
                  /*alignment: Alignment.topLeft,
                          child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                ),
                new Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.all(8.0),



                      child:new Text("Quantity : "+p.q,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                  ),
                  //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                ),
                /*new Row(
                            children: <Widget>[
                              new FlatButton(onPressed: (){
                                //createAlertDialog(context, name.split(': ')[1], imgurl, price.split(': ')[1]);





                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => new item_info(prod_id2[index],imgurl1[index],name1[index],price1[index],description1[index],quantity1[index])));

                                // createAlertDialog(context,item_name[index],imageurl[index],prod_price[index],item_units[index],u[index].data["ProductId"]);
                              },
                                  child:Text("Update")
                              ),
                              new FlatButton(
                                  onPressed: (){

                                    //l[index].toString().split(': ')[1].split(',')[0]
                                    // firestore.collection('users').document(user.uid).collection('cart').document(u[index].data["ProductId"]).delete();


                                    //refreshList();
                                    //Navigator.pop(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));

                                  }, child: Text("Remove")),

                            ],
                          ),*/

              ],
            ),

          ),
        onTap: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => new item_info(widget.pi,p.cat,p.id,(p.img==null)?"https://duckhawk.in/icon.jpeg":p.img,p.name,p.p,p.des,p.q)));
          //Navigator.pop(context);
          /*print(prod_id[index]);
                      print(imgurl1[index]);
                      print(name1[index]);
                      print(price1[index]);
                      print(description1[index]);
                      print(quantity1[index]);*/


        },
      )
    ),
    ),
                /*Card(
                  elevation: 10,
                  borderOnForeground: true,
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(p.img),
                      Text("Sl NO . " +
                          (allProduct.indexOf(p)+1).toString() +
                          " "),
                      Text(p.name),
                      Text(p.des),
                      Text(p.p),
                      Text(p.q),
                      Text(p.id)
                    ],
                  ),
                ),*/
              )
                  .toList())),
      /*Builder(builder: (context) {
        if (pro.toString() != null) {
          return Container(
              child: ListView.builder(
            itemCount: quantity1.length,
            itemBuilder: (BuildContext context, int index) {
              //qu=quantity[index];
              //total_price+=double.parse(prod_price[index])*double.parse(units[index]);
              //return new Text(item_name[index]);
              return new Card(
                child: SingleChildScrollView(
                    child: InkWell(
                  child: ListTile(
                    leading: new Image.network(imgurl1[index],
                        width: 100.0, height: 400.0),
                    title: new Text(name1[index]),
                    subtitle: new Column(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: new Text(
                                "Price : ₹" + price1[index],
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          /*alignment: Alignment.topLeft,
                          child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                        ),
                        new Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: new Text(
                                "Quantity : " + quantity1[index],
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                        ),
                        /*new Row(
                            children: <Widget>[
                              new FlatButton(onPressed: (){
                                //createAlertDialog(context, name.split(': ')[1], imgurl, price.split(': ')[1]);





                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => new item_info(prod_id2[index],imgurl1[index],name1[index],price1[index],description1[index],quantity1[index])));

                                // createAlertDialog(context,item_name[index],imageurl[index],prod_price[index],item_units[index],u[index].data["ProductId"]);
                              },
                                  child:Text("Update")
                              ),
                              new FlatButton(
                                  onPressed: (){

                                    //l[index].toString().split(': ')[1].split(',')[0]
                                    // firestore.collection('users').document(user.uid).collection('cart').document(u[index].data["ProductId"]).delete();


                                    //refreshList();
                                    //Navigator.pop(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));

                                  }, child: Text("Remove")),

                            ],
                          ),*/
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new item_info(
                                widget.s,
                                prod_cat2[index],
                                prod_id2[index],
                                imgurl1[index],
                                name1[index],
                                price1[index],
                                description1[index],
                                quantity1[index])));
                    //Navigator.pop(context);
                    /*print(prod_id[index]);
                      print(imgurl1[index]);
                      print(name1[index]);
                      print(price1[index]);
                      print(description1[index]);
                      print(quantity1[index]);*/
                  },
                )),
              );
            },
          ));
        } else {
          return new Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _title(),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: _title1(),
                          )
                        ],
                      ),
                      //_facebookButton(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),*/

      /* body: Container(
        child: new ListView.builder(
          itemCount: len1,
          itemBuilder: (BuildContext context,int index){
            //qu=quantity[index];
            //total_price+=double.parse(prod_price[index])*double.parse(units[index]);
            //return new Text(item_name[index]);
            return new Card(
              child: SingleChildScrollView(
                  child:InkWell(
                    child: ListTile(

                      leading:
                        new Image.network(imgurl1[index],width:100.0,height:400.0),

                      title:new Text(name1[index]),
                      subtitle: new Column(
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.all(8.0),

                                child:new Text("Price : ₹"+price1[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                            ),
                            /*alignment: Alignment.topLeft,
                          child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                          ),
                          new Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.all(8.0),



                                child:new Text("Quantity : "+quantity1[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                            ),
                            //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                          ),
                          /*new Row(
                            children: <Widget>[
                              new FlatButton(onPressed: (){
                                //createAlertDialog(context, name.split(': ')[1], imgurl, price.split(': ')[1]);





                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => new item_info(prod_id2[index],imgurl1[index],name1[index],price1[index],description1[index],quantity1[index])));

                                // createAlertDialog(context,item_name[index],imageurl[index],prod_price[index],item_units[index],u[index].data["ProductId"]);
                              },
                                  child:Text("Update")
                              ),
                              new FlatButton(
                                  onPressed: (){

                                    //l[index].toString().split(': ')[1].split(',')[0]
                                    // firestore.collection('users').document(user.uid).collection('cart').document(u[index].data["ProductId"]).delete();


                                    //refreshList();
                                    //Navigator.pop(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));

                                  }, child: Text("Remove")),

                            ],
                          ),*/

                        ],
                      ),

                    ),
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => new item_info(widget.s,prod_cat2[index],prod_id2[index],imgurl1[index],name1[index],price1[index],description1[index],quantity1[index])));
                      //Navigator.pop(context);
                      /*print(prod_id[index]);
                      print(imgurl1[index]);
                      print(name1[index]);
                      print(price1[index]);
                      print(description1[index]);
                      print(quantity1[index]);*/


                    },
                  )
              ),
            );
          },



        ),

      ),*/
    );
  }
}

getCartProducts() async {
  li.clear();
  dynamic data;

  print("bye");
  DatabaseReference reference = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user = await _auth.currentUser();
  Future<DocumentSnapshot> s = Firestore.instance
      .collection('users')
      .document(user.uid)
      .collection('cart')
      .document(loc)
      .get();
  s.then((snapshot) {
    print(snapshot);
  });

  /*QuerySnapshot qn = await firestore.collection('users').document(user.uid).collection('cart').document(loc).
      .then((snapshot) {
    snapshot.documents.forEach((f) => li.add(f.documentID));
    u=snapshot.documents;
    print(li[0]);
    /*for(int i=0;i<li.length;i++)
      {
        if(loc==li[i])
          print(li[i]);
      }*/
  });*/

  print("in cart page");
  print(data);
  //print(l[0].toString());
}
