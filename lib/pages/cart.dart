import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/account.dart';
import 'package:project_duckhawk/pages/cart1.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/shared/loading.dart';

import 'orderconfirm.dart';
class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

String seller,imgurl="loading",quantity,price="loading",name="Loading",description,uadd;
String units;
List l=[];
List imageurl=[];
List prod_price=[];
List item_name=[];
List item_quantity=[];
int q=1;
var firestore = Firestore.instance;
FirebaseUser user;

class _cartState extends State<cart> {
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;

  void initState() {
    super.initState();

    getposts();

  }
  getposts() async{
    l.clear();
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = await _auth.currentUser();


    QuerySnapshot qn = await firestore.collection('users').document(user.uid)
        .collection('cart').getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((f) => l.add('${f.data}'));
    });

    print("in cart page");
    print(l);
    print(l[0].split(',')[1].split(': ')[1]);
    ref = reference.child('Products').child('Electronics');
    for (int j = 0; j < l.length; j++){
      reference.child('Products').child('Electronics').child(
          l[j].split(',')[1].split(': ')[1]).once().then((
          DataSnapshot snap) {
        var data = snap.value;
        print("Data");
        print(data);
        seller = data.toString().split(',')[0];
        imgurl = data.toString().split(',')[1];
        quantity = data.toString().split(',')[2];
        price = data.toString().split(',')[3];
        name = data.toString().split(',')[4];
        description = data.toString().split(',')[5];
        imgurl = data.toString().split(',')[1];
        imgurl = imgurl.split(': ')[1];
        quantity = quantity.split(': ')[1];
        price = price.split(': ')[1];
        name = name.split(': ')[1];
        imageurl.add(imgurl);
        prod_price.add(price);
        item_quantity.add(quantity);
        item_name.add(name);
        print("j");
        print(l[j]);
        print(l);
        showDialog(
           context: context,
           builder: (_) => build(context)
         );
      });
    }
    //return qn.documents;

  }
  cod(BuildContext context)
  {
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
            )
          ],
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Conform'),
            onPressed: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new orderconfirm()));


            },
          )
        ],
      );
    });
  }
  createAlertDialog(BuildContext context,String name,String pic,String quantity,String price)
  {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Items available for checkout"),
        content: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(child: Text(name),)
                //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(pic,width:100.0,height:400.0),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("Quantuty: "+quantity+"\n"),
                new Text("Price: "+price,textAlign: TextAlign.end,),
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
              createAlertDialog1(context,name);

            },
          )
        ],
      );
    });
  }

  createAlertDialog1(BuildContext context,String n)
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
              Container(
                height: 150.0,
                child: new TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter Address',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: searchandNavigate,
                        iconSize: 30.0,
                      )
                  ),
                  onChanged: (val) {
                    searchAddr = val;
                  },
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
              ),


            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Submit'),
            onPressed: (){
              Navigator.of(context).pop();
              cod(context);

            },
          )
        ],
      );
    });
  }
  Future<bool> _onWillPop() async {
    for(int m=0;m<=l.length;m++){
      Navigator.pop(context);
    }
  }
  Future<Null>refreshList() async{
    await Future.delayed(Duration(seconds: 2));

    setState(() {
    getposts();
  });
    return null;
  }
  @override
  Widget build(BuildContext context) {
    print("hi");
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
        appBar: new AppBar(
        title: new Text("Cart"),
          backgroundColor: Color(0xff104670),
    ),
      body:RefreshIndicator(
        //child: LogoutOverlay(),
        onRefresh: refreshList,

      child: ListView.builder(
            itemCount: l.length,
            itemBuilder:(_,index){
              print("bye");
              return PostsUI(l[index].toString().split(': ')[1].split(',')[0],imageurl[index],item_name[index],item_quantity[index],prod_price[index]);
            }
        ),
      ),
      bottomNavigationBar: new Container(
          color:Colors.white,
          child:Row(
            children: <Widget>[
              Expanded(
                  child:ListTile(
                    title:new Text("Total Amount :"),
                    subtitle:new Text("Loading"),
                  )
              ),
              Expanded(
                  child:new FlatButton(onPressed: (){

                  },
                    child: Text("Check Out",style: TextStyle(color: Colors.white)),
                    color: Colors.redAccent,
                  )
              )
            ],
          )
      ),

      ),
    );
  }

  Widget PostsUI(String split, String imgurl, String item_name, String item_quantity, String prod_price) {
    print("the image is");
    print(imgurl);
    return new Card(
      child: SingleChildScrollView(
          child:ListTile(
            //leading:new Image.network(imgurl,width:100.0,height:400.0),
            title:new Text(item_name),
            subtitle: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    //new Image.network(imgurl,width:100.0,height:400.0),
                  ],
                ),
                new Container(
                    alignment: Alignment.topLeft,
                    child:new Text(prod_price,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                ),
                new Row(
                  children: <Widget>[
                    new Image.network(imgurl,width:100.0,height:400.0),
                  ],
                ),

                new Row(
                  children: <Widget>[
                    new FlatButton(onPressed: (){
                      createAlertDialog(context,item_name,imgurl,item_quantity,prod_price);
                    },
                        child:Text("Place Order")
                    ),
                    new FlatButton(
                        onPressed: (){
                          firestore.collection('users').document(user.uid).collection('cart').document(split).delete();
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                          refreshList();

                        }, child: Text("Delete")),

                  ],
                ),
              ],
            ),

          )
      ),
    );
   /* return new Card(
        elevation:10.0,
        margin:EdgeInsets.all(15.0),
        child:new Container(
          padding: new EdgeInsets.all(14.0),
          child:new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  //new Image.network(imgurl,width:100.0,height:400.0),
                  new Text(
                    item_name,

                  ),
                  new Text(
                   item_quantity,

                  ),
                  new Text(
                    prod_price,

                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new FlatButton(onPressed: (){
                    //createAlertDialog(context,item_name[index],imageurl[index],item_quantity[index],prod_price[index]);
                  },
                      child:Text("Place Order")
                  ),
                  new FlatButton(
                      onPressed: (){
                        firestore.collection('users').document(user.uid).collection('cart').document(split).delete();
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                        refreshList();

                      }, child: Text("Delete")),

                ],
              ),
            ],
          ),
        )
    );*/
    return new Scaffold(
      body:
      RefreshIndicator(
        onRefresh: refreshList,
        child: new ListView.builder(
          itemCount: l.length,
          itemBuilder: (BuildContext context,int index){
            //return new Text(item_name[index]);
            return new Card(
              child: SingleChildScrollView(
                  child:ListTile(
                    leading:new Image.network(imgurl,width:100.0,height:400.0),
                    title:new Text(item_name),
                    subtitle: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[],
                        ),
                        new Container(
                            alignment: Alignment.topLeft,
                            child:new Text(prod_price,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                        ),
                        new Row(
                          children: <Widget>[
                            new FlatButton(onPressed: (){
                              //createAlertDialog(context,item_name[index],imageurl[index],item_quantity[index],prod_price[index]);
                            },
                                child:Text("Place Order")
                            ),
                            new FlatButton(
                                onPressed: (){
                                  firestore.collection('users').document(user.uid).collection('cart').document(split).delete();
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                                  refreshList();

                                }, child: Text("Delete")),

                          ],
                        ),
                      ],
                    ),

                  )
              ),
            );
          },


        ),),
    );
  }
}

GoogleMapController mapController;
final Map<String, Marker> _markers = {};
String searchAddr;
class LogoutOverlay extends StatefulWidget {
  @override
  _LogoutOverlayState createState() => _LogoutOverlayState();
}

class _LogoutOverlayState extends State<LogoutOverlay> {
  getposts() async{
    final Firestore _firestore = Firestore.instance;
    l.clear();
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = await _auth.currentUser();

    QuerySnapshot qn = await firestore.collection('users').document(user.uid)
        .collection('cart').getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((f) => l.add('${f.data}'));
    });


    print("in cart page");

    print(l[1].toString().split(': ')[1].split(',')[0]);
    print(l.length);
    ref = reference.child('Products').child('Electronics');
    for (int j = 0; j < l.length; j++){
      reference.child('Products').child('Electronics').child(
          l[j].toString().split(': ')[1].split(',')[0]).once().then((
          DataSnapshot snap) {
        var data = snap.value;
        seller = data.toString().split(',')[0];
        imgurl = data.toString().split(',')[1];
        quantity = data.toString().split(',')[2];
        price = data.toString().split(',')[3];
        name = data.toString().split(',')[4];
        description = data.toString().split(',')[5];
        imgurl = data.toString().split(',')[1];
        imgurl = imgurl.split(': ')[1];
        quantity = quantity.split(': ')[1];
        price = price.split(': ')[1];
        name = name.split(': ')[1];
        imageurl.add(imgurl);
        prod_price.add(price);
        item_quantity.add(quantity);
        item_name.add(name);
        //print(item_name);

        showDialog(
            context: context,
            builder: (_) => build(context)
        );
      });
    }
    //return qn.documents;

  }


  createAlertDialog(BuildContext context,String name,String pic,String quantity,String price)
  {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Items available for checkout"),
        content: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(child: Text(name),)
                //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(pic,width:100.0,height:400.0),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("Quantuty: "+quantity+"\n"),
                new Text("Price: "+price,textAlign: TextAlign.end,),
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
              createAlertDialog1(context,name);

            },
          )
        ],
      );
    });
  }

  createAlertDialog1(BuildContext context,String n)
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
              Container(
                height: 150.0,
                child: new TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter Address',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: searchandNavigate,
                        iconSize: 30.0,
                      )
                  ),
                  onChanged: (val) {
                    searchAddr = val;
                  },
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
              ),


            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Submit'),
            onPressed: (){

            },
          )
        ],
      );
    });
  }
  Future<Null>refreshList() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {
    getposts();

  });
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:
          RefreshIndicator(
            onRefresh: refreshList,
        child: new ListView.builder(
          itemCount: l.length,
          itemBuilder: (BuildContext context,int index){
            //return new Text(item_name[index]);
            return new Card(
              child: SingleChildScrollView(
                child:ListTile(
                  leading:new Image.network(imageurl[index],width:100.0,height:400.0),
                  title:new Text(item_name[index]),
                  subtitle: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[],
                      ),
                      new Container(
                        alignment: Alignment.topLeft,
                        child:new Text(prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                      ),
                      new Row(
                        children: <Widget>[
                          new FlatButton(onPressed: (){
                            createAlertDialog(context,item_name[index],imageurl[index],item_quantity[index],prod_price[index]);
                          },
                            child:Text("Place Order")
                          ),
                          new FlatButton(
                              onPressed: (){
                            firestore.collection('users').document(user.uid).collection('cart').document(l[index].toString().split(': ')[1].split(',')[0]).delete();
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                           refreshList();

                          }, child: Text("Delete")),

                        ],
                      ),
                    ],
                  ),

                )
              ),
            );
          },


        ),),
    );
  }
}
void onMapCreated(GoogleMapController controller) {
  mapController=controller;
  _markers.clear();
  final marker = Marker(
      onTap: (){
        print('Tapped');
      },
      draggable: true,
      markerId: MarkerId("curr_loc"),
      position: LatLng(21.5007, 83.8995),

      infoWindow: InfoWindow(title: 'Your Location'),
      onDragEnd: ((value) async {
        print(value.latitude);
        print(value.longitude);
      })
  );
  _markers["Current Location"] = marker;
}

//setMarker() {}

void searchandNavigate() {
  Geolocator().placemarkFromAddress(searchAddr).then((result) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target:
        LatLng(result[0].position.latitude, result[0].position.longitude),
            zoom: 15)));




    _markers.clear();
    final marker = Marker(
        onTap: (){
          print('Tapped');
        },
        draggable: true,
        markerId: MarkerId("curr_loc"),
        position: LatLng(result[0].position.latitude, result[0].position.longitude),

        infoWindow: InfoWindow(title: 'Your Location'),
        onDragEnd: ((value) async {


          print(value.latitude);
          print(value.longitude);
          //final coordinates=new Coordinates(v3,v4);

        })
    );
    _markers["Current Location"] = marker;
    //_getAddressFromLatLng(v3,v4);

/*
      Timer(Duration(seconds: 3), () {
        allMarkers.add(Marker(
            markerId: MarkerId('MyMarker'),
            draggable: true,
            onTap: () {
              print('Marker Tapped');
            },
            position: LatLng(
                result[0].position.latitude, result[0].position.longitude)
        ));
      });*/
  });
}




