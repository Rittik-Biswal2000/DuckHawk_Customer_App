/*import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/model/Orders.dart';
import 'package:project_duckhawk/model/Products.dart';
import 'package:project_duckhawk/model/loc.dart';
import 'package:project_duckhawk/pages/account1.dart';
import 'package:project_duckhawk/pages/edittable.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/pages/olocation.dart';
import 'package:project_duckhawk/pages/location.dart';
import 'package:project_duckhawk/pages/orderconfirm.dart';
import 'package:project_duckhawk/pages/summary.dart';
import 'package:project_duckhawk/pages/categories.dart';
import 'package:http/http.dart' as http;

class cart2 extends StatefulWidget {
  @override
  _cart2State createState() => _cart2State();
}
final _text = TextEditingController();
final _text1 = TextEditingController();
bool _validate = false;
ProgressDialog pr;
class _cart2State extends State<cart2> {
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  String searchAddr;
  cod(BuildContext context,String n,String c,String p,String pr,String q,String i,String sel)
  {
    print("current seller ");
    print(currrentseller);
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("We only accept Cash on Delivery as a mode of payment"),
        content: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/scooter.png',width: 100.0,height: 100.0),
              ],
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("Pay only after you get the product in hand\nNo risk of loss of your hard earned money\nNo dependent on credit or debit cards"),
              ],
            ),


          ],
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Confirm'),
            onPressed: (){
              placeorder(n,c,p,pr,q,i,sel);
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new orderconfirm()));


            },
          )
        ],
      );
    });
  }

  cod2(BuildContext context)
  {
    print("current seller ");
    print(currrentseller);
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("We only accept Cash on Delivery as a mode of payment"),
        content: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/scooter.png',width: 100.0,height: 100.0),
              ],
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("Pay only after you get the product in hand\nNo risk of loss of your hard earned money\nNo dependent on credit or debit cards"),
              ],
            ),


          ],
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Confirm'),

            onPressed: ()async {
              //placeorder(n,c,p,pr,q,i,sel);
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new orderconfirm()));
              pr.show();

              for(var i=0;i<cname.length;i++)
                {
                  await placeorder(cname[i], ccat[i], cimage[i], cprice[i], cquantity[i],  cid[i], cseller[i]);
                }
              pr.hide();





            },
          )
        ],
      );
    });
  }
  createAlertDialog3(BuildContext context)
  {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Items available for checkout"),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Column(
            children: <Widget>[

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text(cname[0].toString()+" & more"),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
              new TextField(
                controller: _text,
                decoration: InputDecoration(
                  hintText: "Enter name",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  errorText: _validate ? 'Name Can\'t Be Empty' : null,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (val) {
                  custname = val;
                },
              ),
              new TextField(
                controller: _text1,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  errorText: _validate ? 'Phone number Can\'t Be Empty' : null,
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  custphone= val;
                },
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text("Address"),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),

              SizedBox(height: 20.0),
              new Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: new RaisedButton(
                  onPressed: () async{
                    /*pr.show();
                      var loc=await ge();
                      print("Current Location is : "+loc.toString());*/

                    await Navigator.push(context, MaterialPageRoute(builder: (context) => new olocation()));
                    print("In Item_info Page");
                    print(latitude1);
                    print(longitude1);


                  },
                  child: new Text("Choose Your Location"),

                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:  new InkWell(
                    onTap: () async{
                      //await Navigator.push(context, MaterialPageRoute(builder: (context) => new MyLocation()));
                    },
                    child: ListTile(title: Text("Enter your Address"))
                  //child: ListTile(title: Text(widget.oloc==null?" ":'${widget.oloc}',maxLines: null,)),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:  new InkWell(
                    onTap: () async{
                      //await Navigator.push(context, MaterialPageRoute(builder: (context) => new MyLocation()));
                    },
                    child: ListTile(title: TextField(
                        maxLines: null,
                        decoration: InputDecoration(hintText: 'Enter Address'),
                        onChanged: (value) {
                          setState(() {
                            iadd = value;
                          });
                        }),)
                  //child: ListTile(title: Text(widget.oloc==null?" ":'${widget.oloc}',maxLines: null,)),
                ),
              ),
              SizedBox(height: 20.0),
              /*new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text("Address"),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),

              Container(
                height: 150.0,
                child: InkWell(
                  onTap: (){
                    //getpredictions();

                  },
                  child:Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('${searchAddr}', maxLines: null,),

                  ),

                ),


              ),


              Container(
                height: 200.0,
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(21.5007, 83.8995),
                    zoom: 10.0,),
                  markers: _markers.values.toSet(),



                ),
              ),*/


            ],
          ),

        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Submit'),
            onPressed: (){
              /* setState(() {
                _text.text.isEmpty ? _validate = true : _validate = false;
                _text1.text.isEmpty ? _validate = true : _validate = false;
              });*/
              if(_text.text.isNotEmpty&&_text1.text.isNotEmpty){
                Navigator.of(context).pop();
                cod2(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => new oc()));
              }



            },
          )
        ],
      );
    });
  }

  createAlertDialog1(BuildContext context,String n,String c,String p,String pr,String q,String i,String s)
  {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Items available for checkout"),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Column(
            children: <Widget>[

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text(n),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
              new TextField(
                controller: _text,
                decoration: InputDecoration(
                  hintText: "Enter name",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  errorText: _validate ? 'Name Can\'t Be Empty' : null,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (val) {
                  custname = val;
                },
              ),
              new TextField(
                controller: _text1,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  errorText: _validate ? 'Phone number Can\'t Be Empty' : null,
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  custphone= val;
                },
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text("Address"),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),

              SizedBox(height: 20.0),
              new Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: new RaisedButton(
                  onPressed: () async{
                    /*pr.show();
                      var loc=await ge();
                      print("Current Location is : "+loc.toString());*/

                    await Navigator.push(context, MaterialPageRoute(builder: (context) => new olocation()));
                    print("In Item_info Page");
                    print(latitude1);
                    print(longitude1);


                  },
                  child: new Text("Choose Your Location"),

                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:  new InkWell(
                    onTap: () async{
                      //await Navigator.push(context, MaterialPageRoute(builder: (context) => new MyLocation()));
                    },
                    child: ListTile(title: Text("Enter your Address"))
                  //child: ListTile(title: Text(widget.oloc==null?" ":'${widget.oloc}',maxLines: null,)),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:  new InkWell(
                    onTap: () async{
                      //await Navigator.push(context, MaterialPageRoute(builder: (context) => new MyLocation()));
                    },
                    child: ListTile(title: TextField(
                        maxLines: null,
                        decoration: InputDecoration(hintText: 'Enter Address'),
                        onChanged: (value) {
                          setState(() {
                            iadd = value;
                          });
                        }),)
                  //child: ListTile(title: Text(widget.oloc==null?" ":'${widget.oloc}',maxLines: null,)),
                ),
              ),
              SizedBox(height: 20.0),
              /*new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text("Address"),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),

              Container(
                height: 150.0,
                child: InkWell(
                  onTap: (){
                    //getpredictions();

                  },
                  child:Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('${searchAddr}', maxLines: null,),

                  ),

                ),


              ),


              Container(
                height: 200.0,
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(21.5007, 83.8995),
                    zoom: 10.0,),
                  markers: _markers.values.toSet(),



                ),
              ),*/


            ],
          ),

        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Submit'),
            onPressed: (){
              /* setState(() {
                _text.text.isEmpty ? _validate = true : _validate = false;
                _text1.text.isEmpty ? _validate = true : _validate = false;
              });*/
              if(_text.text.isNotEmpty&&_text1.text.isNotEmpty){
                Navigator.of(context).pop();
                cod(context,n,c,p,pr,q,i,s);
              }



            },
          )
        ],
      );
    });
  }
  createAlertDialog2(BuildContext context,String name,String cat,String pic,String price,String quantity,String id,String seller)
  {
    var to=double.parse(price)*double.parse(quantity);

    //total=double.parse(price)*double.parse(quantity);
    print("in 1st dialog box");
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AlertDialog(

          title: Text("Items available for checkout"),
          content: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text(name),
                    ),
                  )
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],

              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(pic,width:100.0,height:200.0),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("Quantity: "+quantity),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("Price: ₹"+price,textAlign: TextAlign.end,),
                ],
              ),
              new Row(


                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text("Total : ₹"+to.toString(),textAlign: TextAlign.end,),
                  ),

                ],
              )
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              elevation:5.0,
              child: Text('Submit'),
              onPressed: (){
                Navigator.of(context).pop();
                createAlertDialog1(context,name,cat,pic,price,quantity,id,seller);

              },
            )
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    print("City in Cart page is :"+loc);

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xff104670),
        title: Text('Cart'),
      ),
      endDrawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            /*InkWell(
              child: new UserAccountsDrawerHeader(


                //accountName: Text(name),



              ),
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>new LoginPage()));
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new account()));
              },
            ),*/
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage(null)));
              },
              child: ListTile(
                title: Text('Shop'),
              ),
            ),

            InkWell(
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Fashion")));

              },
              child: ListTile(
                title: Text('Search'),
              ),
            ),
            InkWell(
              onTap: () async{
                Navigator.pop(context);
                pr.show();
                await getuac();
                pr.hide();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new acc1()));
              },
              child: ListTile(title: Text('Account')),
            ),
            InkWell(
              onTap: () async{

                Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart2()));
              },
              child: ListTile(title: Text('Cart')),
            ),/*
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Books")));
              },
              child: ListTile(title: Text('Books')),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Home & Furniture")));
              },
              child: ListTile(title: Text('Home & Furniture')),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Beauty & Personal Care")));
              },
              child: ListTile(title: Text('Beauty & Personal Care')),
            ),
            Divider(),
            Container(
                color: Color(0xffaaaaaa),
                child: new Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('My Orders')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));
                      },
                      child: ListTile(title: Text('My Cart')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new account()));
                      },
                      child: ListTile(title: Text('Account')),
                    ),
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Notifications')),
                    ),*/
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Budget')),
                    ),*/
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Share')),
                    ),*/
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Settings')),
                    ),*/
                    InkWell(
                      onTap: () {
                        _signOut();

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new WelcomePage()));
                        name="Login";
                      },
                      child: ListTile(title: Text('Logout')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new help()));
                      },
                      child: ListTile(title: Text('Help')),
                    )
                  ],
                )),*/
          ],
        ),
      ),
      body:Container(
    child:  ListView.builder(
          itemCount: clength,
          itemBuilder: (context,index){
            return new Card(
              child: SingleChildScrollView(
                child:ListTile(

                  leading:InkWell(
                      onTap: (){
                      },
                      child:
                      new Image.network(cimage[index],width:100.0,height:400.0)
                  ),
                  title:new Text(cname[index]),
                  subtitle: new Column(
                    children: <Widget>[
                      new Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.all(8.0),

                            child:new Text("Price : ₹"+cprice[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                        ),
                        /*alignment: Alignment.topLeft,
                        child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                      ),
                      new Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.all(8.0),

                            child:new Text("Quantity : "+cquantity[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                        ),
                        //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                      ),
                      new Row(
                        children: <Widget>[
                         /* new FlatButton(onPressed: (){
                            print("in cart2");
                            print(ccat[index]);
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>new summary(cname[index],ccat[index],cimage[index],cprice[index],cquantity[index],cid[index],cseller[index])));
                            createAlertDialog2(context,cname[index],ccat[index],cimage[index],cprice[index],cquantity[index],cid[index],cseller[index]);
                          },
                              child:Text("Place Order")
                          ),*/
                          new FlatButton(
                              color: Colors.red,
                              onPressed: ()async{

                                pr.show();
                                FirebaseUser user=await FirebaseAuth.instance.currentUser();
                                /*for(int j=0;j<cseller.length;j++)
                                  {
                                    await Firestore.instance.collection('users').document(user.uid).collection('cart').document(loc).collection(cseller[j]).document().delete();

                                  }*/
                                await Firestore.instance.collection('users').document(user.uid).collection('cart').document(loc).collection(cseller[index]).document(cid[index]).delete();
                                await getcartData();
                                pr.hide();
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart2()));


                                //l[index].toString().split(': ')[1].split(',')[0]
                                //firestore.collection('users').document(user.uid).collection('cart').document(u[index].data["ProductId"]).delete();


                                //refreshList();
                                //Navigator.pop(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));

                              }, child: Text("Delete")),

                        ],
                      ),
                    ],
                  ),

                ),

              ),

            );

          })
    ),
      bottomNavigationBar: new Container(
          color:Colors.white,
          child:Row(
            children: <Widget>[
              Expanded(
                  child:ListTile(
                    title:new Text("Total Amount :"),
                    subtitle:new Text(ctotal.toString()),
                  )
              ),
              Expanded(
                  child:new FlatButton(onPressed: (){
                    createAlertDialog3(context);
                  },
                    child: Text("Check Out",style: TextStyle(color: Colors.white)),
                    color: Colors.redAccent,
                  )
              )
            ],
          )
      ),
    );
  }
}
placeorder(String name,String cat,String image,String price,String quantity,String id,String seller) async {
  FirebaseUser user=await FirebaseAuth.instance.currentUser();
  DatabaseReference _database=FirebaseDatabase.instance.reference();
  var now = new DateTime.now();
  //print(now.millisecondsSinceEpoch);
  var d=new DateFormat("dd-MM-yyyy").format(now);
  var t=new DateFormat("H:m:s").format(now);
  String time=d.toString()+" "+t.toString();
  print(currrentseller);

   Orders todo = new Orders(iadd, user.uid, seller, time, double.parse(price));
  Products prod = new Products(id, cat, loc, double.parse(price), double.parse(quantity), seller);
  locs loc1 = new locs(latitude1, longitude1);
  DatabaseReference rootRef=FirebaseDatabase.instance.reference();
  String newkey=rootRef.child('Orders').child(loc).push().key;
  await rootRef.child('Orders').child(loc).child(newkey).set(todo.toJson());
  //await _database.reference().child("Orders").child(loc).push().set(todo.toJson());
  String link = "https://duckhawk-1699a.firebaseio.com/Orders/"+loc+".json";
  final resource = await http.get(link);
  if (resource.statusCode == 200) {
    LinkedHashMap<String, dynamic> data = jsonDecode(resource.body);
    List list = data.keys.toList();
    length = list.length;
    print(list);
    print('Seller list');
    String y = list[length-1];
    print(y);
    await _database.reference().child("Orders").child(loc).child(y).child("Products").child(id).set(prod.toJson());
    await _database.reference().child("Orders").child(loc).child(y).child("location").set(loc1.toJson());
    await Firestore.instance.collection('users').document(user.uid).collection('orders').document(newkey).setData({

      'city':loc,
      'time':time,
      'total':double.parse(price)*double.parse(quantity),

    });
  }
//  todo.completed = true;
//  if (todo != null) {
//    _database.reference().child("Todo").child("Bhubaneswar").set(todo.toJson());
//  }
  print("hello data added in firebase");
  await Firestore.instance.collection('users').document(user.uid).collection('cart').document(loc).collection(seller).document(id).delete();
  print(newkey);

}
*/
import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/model/Orders.dart';
import 'package:project_duckhawk/model/Products.dart';
import 'package:project_duckhawk/model/loc.dart';
import 'package:project_duckhawk/pages/account1.dart';
import 'package:project_duckhawk/pages/edittable.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/pages/olocation.dart';
import 'package:project_duckhawk/pages/orderconfirm.dart';
import 'package:project_duckhawk/pages/summary.dart';
import 'package:project_duckhawk/pages/categories.dart';
import 'package:http/http.dart' as http;

class cart2 extends StatefulWidget {
  @override
  _cart2State createState() => _cart2State();
}
final _text = TextEditingController();
final _text1 = TextEditingController();
bool _validate = false;
ProgressDialog pr;
class _cart2State extends State<cart2> {
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  String searchAddr;
  cod(BuildContext context,String n,String c,String p,String pr,String q,String i,String sel)
  {
    print("current seller ");
    print(currrentseller);
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("We only accept Cash on Delivery as a mode of payment"),
        content: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/scooter.png',width: 100.0,height: 100.0),
              ],
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("Pay only after you get the product in hand\nNo risk of loss of your hard earned money\nNo dependent on credit or debit cards"),
              ],
            ),


          ],
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Confirm'),
            onPressed: (){
              placeorder(n,c,p,pr,q,i,sel);
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new orderconfirm()));


            },
          )
        ],
      );
    });
  }

  cod2(BuildContext context)
  {
    print("current seller ");
    print(currrentseller);
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("We only accept Cash on Delivery as a mode of payment"),
        content: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/scooter.png',width: 100.0,height: 100.0),
              ],
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("Pay only after you get the product in hand\nNo risk of loss of your hard earned money\nNo dependent on credit or debit cards"),
              ],
            ),


          ],
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Confirm'),

            onPressed: ()async {
              //placeorder(n,c,p,pr,q,i,sel);
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new orderconfirm()));
              pr.show();

              for(var i=0;i<cname.length;i++)
              {
                await placeorder(cname[i], ccat[i], cimage[i], cprice[i], cquantity[i],  cid[i], cseller[i]);
              }
              pr.hide();





            },
          )
        ],
      );
    });
  }
  createAlertDialog3(BuildContext context)
  {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Items available for checkout"),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Column(
            children: <Widget>[

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text(cname[0].toString()+" & more"),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
              new TextField(
                controller: _text,
                decoration: InputDecoration(
                  hintText: "Enter name",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  errorText: _validate ? 'Name Can\'t Be Empty' : null,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (val) {
                  custname = val;
                },
              ),
              new TextField(
                controller: _text1,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  errorText: _validate ? 'Phone number Can\'t Be Empty' : null,
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  custphone= val;
                },
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text("Address"),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),

              SizedBox(height: 20.0),
              new Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: new RaisedButton(
                  onPressed: () async{
                    /*pr.show();
                      var loc=await ge();
                      print("Current Location is : "+loc.toString());*/

                    await Navigator.push(context, MaterialPageRoute(builder: (context) => new olocation()));
                    print("In Item_info Page");
                    print(latitude1);
                    print(longitude1);


                  },
                  child: new Text("Choose Your Location"),

                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:  new InkWell(
                    onTap: () async{
                      //await Navigator.push(context, MaterialPageRoute(builder: (context) => new MyLocation()));
                    },
                    child: ListTile(title: Text("Enter your Address"))
                  //child: ListTile(title: Text(widget.oloc==null?" ":'${widget.oloc}',maxLines: null,)),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:  new InkWell(
                    onTap: () async{
                      //await Navigator.push(context, MaterialPageRoute(builder: (context) => new MyLocation()));
                    },
                    child: ListTile(title: TextField(
                        maxLines: null,
                        decoration: InputDecoration(hintText: 'Enter Address'),
                        onChanged: (value) {
                          setState(() {
                            iadd = value;
                          });
                        }),)
                  //child: ListTile(title: Text(widget.oloc==null?" ":'${widget.oloc}',maxLines: null,)),
                ),
              ),
              SizedBox(height: 20.0),
              /*new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text("Address"),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),

              Container(
                height: 150.0,
                child: InkWell(
                  onTap: (){
                    //getpredictions();

                  },
                  child:Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('${searchAddr}', maxLines: null,),

                  ),

                ),


              ),


              Container(
                height: 200.0,
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(21.5007, 83.8995),
                    zoom: 10.0,),
                  markers: _markers.values.toSet(),



                ),
              ),*/


            ],
          ),

        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Submit'),
            onPressed: (){
              /* setState(() {
                _text.text.isEmpty ? _validate = true : _validate = false;
                _text1.text.isEmpty ? _validate = true : _validate = false;
              });*/
              if(_text.text.isNotEmpty&&_text1.text.isNotEmpty){
                Navigator.of(context).pop();
                cod2(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => new oc()));
              }



            },
          )
        ],
      );
    });
  }

  createAlertDialog1(BuildContext context,String n,String c,String p,String pr,String q,String i,String s)
  {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Items available for checkout"),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Column(
            children: <Widget>[

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text(n),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
              new TextField(
                controller: _text,
                decoration: InputDecoration(
                  hintText: "Enter name",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  errorText: _validate ? 'Name Can\'t Be Empty' : null,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (val) {
                  custname = val;
                },
              ),
              new TextField(
                controller: _text1,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  errorText: _validate ? 'Phone number Can\'t Be Empty' : null,
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  custphone= val;
                },
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text("Address"),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),

              SizedBox(height: 20.0),
              new Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: new RaisedButton(
                  onPressed: () async{
                    /*pr.show();
                      var loc=await ge();
                      print("Current Location is : "+loc.toString());*/

                    await Navigator.push(context, MaterialPageRoute(builder: (context) => new olocation()));
                    print("In Item_info Page");
                    print(latitude1);
                    print(longitude1);


                  },
                  child: new Text("Choose Your Location"),

                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:  new InkWell(
                    onTap: () async{
                      //await Navigator.push(context, MaterialPageRoute(builder: (context) => new MyLocation()));
                    },
                    child: ListTile(title: Text("Enter your Address"))
                  //child: ListTile(title: Text(widget.oloc==null?" ":'${widget.oloc}',maxLines: null,)),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:  new InkWell(
                    onTap: () async{
                      //await Navigator.push(context, MaterialPageRoute(builder: (context) => new MyLocation()));
                    },
                    child: ListTile(title: TextField(
                        maxLines: null,
                        decoration: InputDecoration(hintText: 'Enter Address'),
                        onChanged: (value) {
                          setState(() {
                            iadd = value;
                          });
                        }),)
                  //child: ListTile(title: Text(widget.oloc==null?" ":'${widget.oloc}',maxLines: null,)),
                ),
              ),
              SizedBox(height: 20.0),
              /*new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text("Address"),)
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),

              Container(
                height: 150.0,
                child: InkWell(
                  onTap: (){
                    //getpredictions();

                  },
                  child:Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('${searchAddr}', maxLines: null,),

                  ),

                ),


              ),


              Container(
                height: 200.0,
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(21.5007, 83.8995),
                    zoom: 10.0,),
                  markers: _markers.values.toSet(),



                ),
              ),*/


            ],
          ),

        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Submit'),
            onPressed: (){
              /* setState(() {
                _text.text.isEmpty ? _validate = true : _validate = false;
                _text1.text.isEmpty ? _validate = true : _validate = false;
              });*/
              if(_text.text.isNotEmpty&&_text1.text.isNotEmpty){
                Navigator.of(context).pop();
                cod(context,n,c,p,pr,q,i,s);
              }



            },
          )
        ],
      );
    });
  }
  createAlertDialog2(BuildContext context,String name,String cat,String pic,String price,String quantity,String id,String seller)
  {
    var to=double.parse(price)*double.parse(quantity);

    //total=double.parse(price)*double.parse(quantity);
    print("in 1st dialog box");
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AlertDialog(

          title: Text("Items available for checkout"),
          content: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text(name),
                    ),
                  )
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],

              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(pic,width:100.0,height:200.0),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("Quantity: "+quantity),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("Price: ₹"+price,textAlign: TextAlign.end,),
                ],
              ),
              new Row(


                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text("Total : ₹"+to.toString(),textAlign: TextAlign.end,),
                  ),

                ],
              )
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              elevation:5.0,
              child: Text('Submit'),
              onPressed: (){
                Navigator.of(context).pop();
                createAlertDialog1(context,name,cat,pic,price,quantity,id,seller);

              },
            )
          ],
        ),
      );
    });
  }


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
          children: [/*
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xff104670), fontSize: 30),
            ),
         */ ]),
    );
  }
  Widget _title1() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Your Cart is Empty!',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.display1,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xff104670),
        ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    print("City in Cart page is :"+loc);

    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff104670),
          title: Text('Cart'),
        ),
        bottomNavigationBar: new Container(
            color:Colors.white,
            child:Row(
              children: <Widget>[
                Expanded(
                    child:ListTile(
                      title:new Text("Total Amount :"),
                      subtitle:new Text(ctotal.toString()),
                    )
                ),
                Expanded(
                    child:new FlatButton(onPressed: (){
                      createAlertDialog3(context);
                    },
                      child: Text("Check Out",style: TextStyle(color: Colors.white)),
                      color: Colors.redAccent,
                    )
                )
              ],
            )
        ),
        endDrawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              /*InkWell(
              child: new UserAccountsDrawerHeader(


                //accountName: Text(name),



              ),
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>new LoginPage()));
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new account()));
              },
            ),*/
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage(null)));
                },
                child: ListTile(
                  title: Text('Shop'),
                ),
              ),

              InkWell(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Fashion")));

                },
                child: ListTile(
                  title: Text('Search'),
                ),
              ),
              InkWell(
                onTap: () async{
                  Navigator.pop(context);
                  pr.show();
                  await getuac();
                  pr.hide();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new acc1()));
                },
                child: ListTile(title: Text('Account')),
              ),
              InkWell(
                onTap: () async{

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart2()));
                },
                child: ListTile(title: Text('Cart')),
              ),/*
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Books")));
              },
              child: ListTile(title: Text('Books')),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Home & Furniture")));
              },
              child: ListTile(title: Text('Home & Furniture')),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Beauty & Personal Care")));
              },
              child: ListTile(title: Text('Beauty & Personal Care')),
            ),
            Divider(),
            Container(
                color: Color(0xffaaaaaa),
                child: new Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('My Orders')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));
                      },
                      child: ListTile(title: Text('My Cart')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new account()));
                      },
                      child: ListTile(title: Text('Account')),
                    ),
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Notifications')),
                    ),*/
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Budget')),
                    ),*/
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Share')),
                    ),*/
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Settings')),
                    ),*/
                    InkWell(
                      onTap: () {
                        _signOut();

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new WelcomePage()));
                        name="Login";
                      },
                      child: ListTile(title: Text('Logout')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new help()));
                      },
                      child: ListTile(title: Text('Help')),
                    )
                  ],
                )),*/
            ],
          ),
        ),


        body: Builder(
            builder: (context) {
              if (suid.isNotEmpty) {
                return Container(
                    child:  ListView.builder(
                        itemCount: clength,
                        itemBuilder: (context,index){
                          return new Card(
                            child: SingleChildScrollView(
                              child:ListTile(

                                leading:InkWell(
                                    onTap: (){
                                    },
                                    child:
                                    new Image.network(cimage[index],width:100.0,height:400.0)
                                ),
                                title:new Text(cname[index]),
                                subtitle: new Column(
                                  children: <Widget>[
                                    new Container(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                          padding: EdgeInsets.all(8.0),

                                          child:new Text("Price : ₹"+cprice[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                      ),
                                      /*alignment: Alignment.topLeft,
                        child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                                    ),
                                    new Container(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                          padding: EdgeInsets.all(8.0),

                                          child:new Text("Quantity : "+cquantity[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                      ),
                                      //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        /* new FlatButton(onPressed: (){
                            print("in cart2");
                            print(ccat[index]);
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>new summary(cname[index],ccat[index],cimage[index],cprice[index],cquantity[index],cid[index],cseller[index])));
                            createAlertDialog2(context,cname[index],ccat[index],cimage[index],cprice[index],cquantity[index],cid[index],cseller[index]);
                          },
                              child:Text("Place Order")
                          ),*/
                                        new FlatButton(
                                            color: Colors.red,
                                            onPressed: ()async{

                                              pr.show();
                                              FirebaseUser user=await FirebaseAuth.instance.currentUser();
                                              /*for(int j=0;j<cseller.length;j++)
                                  {
                                    await Firestore.instance.collection('users').document(user.uid).collection('cart').document(loc).collection(cseller[j]).document().delete();

                                  }*/
                                              await Firestore.instance.collection('users').document(user.uid).collection('cart').document(loc).collection(cseller[index]).document(cid[index]).delete();
                                              await getcartData();
                                              pr.hide();
                                              Navigator.pop(context);
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart2()));


                                              //l[index].toString().split(': ')[1].split(',')[0]
                                              //firestore.collection('users').document(user.uid).collection('cart').document(u[index].data["ProductId"]).delete();


                                              //refreshList();
                                              //Navigator.pop(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));

                                            }, child: Text("Delete")),

                                      ],
                                    ),
                                  ],
                                ),

                              ),

                            ),

                          );

                        })
                );
                bottomNavigationBar: new Container(
                    color:Colors.white,
                    child:Row(
                      children: <Widget>[
                        Expanded(
                            child:ListTile(
                              title:new Text("Total Amount :"),
                              subtitle:new Text(ctotal.toString()),
                            )
                        ),
                        Expanded(
                            child:new FlatButton(onPressed: (){
                              createAlertDialog3(context);
                            },
                              child: Text("Check Out",style: TextStyle(color: Colors.white)),
                              color: Colors.redAccent,
                            )
                        )
                      ],
                    )
                );}
              else
              {

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

            }
            )
    );
  }
}
placeorder(String name,String cat,String image,String price,String quantity,String id,String seller) async {
  FirebaseUser user=await FirebaseAuth.instance.currentUser();
  DatabaseReference _database=FirebaseDatabase.instance.reference();
  var now = new DateTime.now();
  //print(now.millisecondsSinceEpoch);
  var d=new DateFormat("dd-MM-yyyy").format(now);
  var t=new DateFormat("H:m:s").format(now);
  String time=d.toString()+" "+t.toString();
  print(currrentseller);

  Orders todo = new Orders(iadd, user.uid, seller, time, double.parse(price));
  Products prod = new Products(id, cat, loc, double.parse(price), double.parse(quantity), seller);
  locs loc1 = new locs(latitude1, longitude1);
  DatabaseReference rootRef=FirebaseDatabase.instance.reference();
  String newkey=rootRef.child('Orders').child(loc).push().key;
  await rootRef.child('Orders').child(loc).child(newkey).set(todo.toJson());
  //await _database.reference().child("Orders").child(loc).push().set(todo.toJson());
  String link = "https://duckhawk-1699a.firebaseio.com/Orders/"+loc+".json";
  final resource = await http.get(link);
  if (resource.statusCode == 200) {
    LinkedHashMap<String, dynamic> data = jsonDecode(resource.body);
    List list = data.keys.toList();
    length = list.length;
    print(list);
    print('Seller list');
    String y = list[length-1];
    print(y);
    await _database.reference().child("Orders").child(loc).child(y).child("Products").child(id).set(prod.toJson());
    await _database.reference().child("Orders").child(loc).child(y).child("location").set(loc1.toJson());
    await Firestore.instance.collection('users').document(user.uid).collection('orders').document(newkey).setData({

      'city':loc,
      'time':time,
      'total':double.parse(price)*double.parse(quantity),

    });
  }
//  todo.completed = true;
//  if (todo != null) {
//    _database.reference().child("Todo").child("Bhubaneswar").set(todo.toJson());
//  }
  print("hello data added in firebase");
  await Firestore.instance.collection('users').document(user.uid).collection('cart').document(loc).collection(seller).document(id).delete();
  print(newkey);

}


