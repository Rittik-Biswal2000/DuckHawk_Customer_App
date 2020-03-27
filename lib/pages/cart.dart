import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/account.dart';
import 'package:project_duckhawk/pages/cart1.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:project_duckhawk/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';

import 'orderconfirm.dart';
class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}
double total=0;
double total_price=0;
String custname,custphone;
final _text = TextEditingController();
final _text1 = TextEditingController();
bool _validate = false;

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyC52Z3z1WF_y0Q0dbYfexizoexgAnSTov0");
String seller,imgurl="loading",quantity,price="loading",name="Loading",description,uadd;
String _selectedLocation=" ";
String units=' ',_dropDownValue=" ";
String p='1';
String searchAddr,fadd;
int count=1;
var x;

List l=[];
List<String> quan=[];
List<String> unit=[];
List imageurl=[];
List prod_price=[];
List item_name=[];
List item_quantity=[];
List item_units=[];
int q=1;
var firestore = Firestore.instance;
FirebaseUser user;
var u;

class _cartState extends State<cart> {
  //List<Manga> _listContent = new List<Manga>();
  String selected=null;
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;




  void initState() {
    super.initState();

    getposts();

  }
  getposts() async{
    total=0;
    l.clear();
    quan.clear();
    unit.clear();
    imageurl.clear();
    prod_price.clear();
    item_name.clear();
    item_quantity.clear();
    item_units.clear();
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = await _auth.currentUser();


    QuerySnapshot qn = await firestore.collection('users').document(user.uid)
        .collection('cart').getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((f) => l.add('${f.data}'));
      u=snapshot.documents;
    });


    print("in cart page");
    //print(l[0].toString());
    print(u[0].data['category']);
    int k;
    item_units.clear();
    for( k=0;k<l.length;k++){
      item_units.add(u[k].data['quantity']);
    }
    print(item_units);

    //print(l[0].split(',')[0].split(': ')[1]);
    ref = reference.child('Products').child('Electronics');
    for (int j = 0; j < l.length; j++){
      reference.child('Products').child('Bhubaneswar').child('Electronics').child(
          u[j].data['ProductId']).once().then((
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
        units=l[0].split(',')[0].split(': ')[1];
        imageurl.add(imgurl);
        prod_price.add(price);
        item_quantity.add(quantity);
        item_name.add(name);
        print("j");
        //print(l[j]);
        //print(l);
        /*x=0;
         x = int.parse(quantity);
        print(x.runtimeType);
        print("x is :");
        //print(x);
       // quan.clear();
        unit.clear();
        quan.add(x.toString());
        print("Quantity is ");
        var y=int.parse(quan[j]);
        while(y>0){
          unit.add((y--).toString());
          print(unit);
        }*/
        total_price=0;
        for(int p=0;p<l.length;p++){

          total_price+=double.parse(item_units[p])*double.parse(prod_price[p]);
          print(total_price);
        }
        firestore
            .collection("users").where("uid", isEqualTo: user.uid)
            .getDocuments()
            .then((QuerySnapshot snapshot) {

          snapshot.documents.forEach((f) => uadd = '${f.data}');
          print("Address is:");
          print(uadd);
          //print(uadd.split(',')[2].split(': ')[1]);
          fadd=uadd.split(',')[2].split(': ')[1];
          //searchAddr=fadd.replaceAll(' ', '\n');
          searchAddr=fadd;
          getpoint(searchAddr);

        });
        print("total price is :");
        print(total_price);
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
            ),


          ],
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Confirm'),
            onPressed: (){
              placeorder1();
              sendmsg();
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new orderconfirm()));
              firestore.collection('users').document(user.uid).collection('cart').getDocuments().then((snapshot) {
                for (DocumentSnapshot ds in snapshot.documents) {
                  ds.reference.delete();
                }
              });


            },
          )
        ],
      );
    });
  }
  createAlertDialog(BuildContext context,String name,String pic,String price)
  {

    total=double.parse(price)*double.parse(units);
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
                  new Text("Quantity: "+units),
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
                    child: new Text("Total : ₹"+total.toString(),textAlign: TextAlign.end,),
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
                createAlertDialog1(context,name);

              },
            )
          ],
        ),
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

              Container(
                height: 150.0,
                child: InkWell(
                  onTap: (){
                    getpredictions();

                  },
                  child:Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('${searchAddr}', maxLines: null,),

                  ),

                ),

                /* new TextField(
                    decoration: InputDecoration(
                        hintText: fadd.replaceAll(' ', '\n'),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: searchandNavigate,
                          iconSize: 30.0,
                        )
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) {
                      searchAddr = val;
                    },
                  ),*/
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
              setState(() {
                _text.text.isEmpty ? _validate = true : _validate = false;
                _text1.text.isEmpty ? _validate = true : _validate = false;
              });
              if(_text.text.isNotEmpty&&_text1.text.isNotEmpty){
                Navigator.of(context).pop();
                cod(context);
              }



            },
          )
        ],
      );
    });
  }
  Future<bool> _onWillPop() async {
    Navigator.pop(context, MaterialPageRoute(builder: (context)=>new cart()));
    Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage(null)));
  }
  Future<Null>refreshList() async{
    await Future.delayed(Duration(seconds: 2));
    getposts();
    setState(() {

      cart();
    });
    return null;
  }
  String textholder='1';
  increment(String item_quantity) {

    int x1=1;

    setState(() {
      textholder=(x1++).toString();
    });

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
          child: LogoutOverlay(),
          onRefresh: refreshList,

          /*child: ListView.builder(
            itemCount: l.length,
            itemBuilder:(_,index){
              print("bye");
              return PostsUI(l[index].split(',')[1].split(': ')[1],imageurl[index],item_name[index],item_quantity[index],prod_price[index]);
            }
        ),*/
        ),
        bottomNavigationBar: new Container(
            color:Colors.white,
            child:Row(
              children: <Widget>[
                Expanded(
                    child:ListTile(
                      title:new Text("Total Amount :"),
                      subtitle:new Text(total_price.toString()),
                    )
                ),
                Expanded(
                    child:new FlatButton(onPressed: (){
                      createAlertDialog1(context,item_name[0]+" others");
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
  int i=1;
  getpredictions() async{
    Prediction p = await PlacesAutocomplete.show(
        context: context, apiKey: "AIzaSyC52Z3z1WF_y0Q0dbYfexizoexgAnSTov0");
    displayPrediction(p);
  }
  Future<String> displayPrediction(Prediction p) async {
    String x;
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);
      print("Address is");
      final coordinates=new Coordinates(lat,lng);
      var addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first=addresses.first;
      //print("${first.featureName}:${first.addressLine}");
      x=first.addressLine;
      print(lat);
      print(lng);
      searchAddr="${first.addressLine}";
      print(searchAddr);






      searchandNavigate(x);
    }
  }

  placeorder1() {
    int a;
    for(a=0;a<l.length;a++){
      FirebaseDatabase.instance.reference().child('Orders').child(user.uid).push().set(
          {
            'Address':searchAddr,
            'buyer':custname,
            'location':lat.toString()+","+lon.toString(),
            'phone':custphone,
            'prodcat':u[a].data["category"],
            'productid':u[a].data['ProductId'],
            'price':double.parse(item_units[a])*double.parse(prod_price[a])
          }



      );

    }

  }
/* Widget PostsUI(String split, String imgurl, String item_name, String item_quantity, String prod_price) {
    String q=item_quantity;
    int qt=int.parse(q);
    unit.clear();
    print("the image is");
    var x=int.parse(item_quantity);
    while(x!=0){
      unit.add((x--).toString());
    }
    /*while(x!=0){
      unit.add(new DropdownMenuItem(child:
      new Text((x--).toString()),
      value: (i++).toString(),
      ));
    }*/
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
                    Container(
                      padding: EdgeInsets.fromLTRB(20,20,20,20),
                      child: Text('${textholder}'),
                    ),
                    RaisedButton(
                        onPressed: ()=>increment(item_quantity),
                        child:Text("Increase")
                    ),
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
  }*/




}

GoogleMapController mapController;
final Map<String, Marker> _markers = {};
class LogoutOverlay extends StatefulWidget {
  @override
  _LogoutOverlayState createState() => _LogoutOverlayState();
}

class _LogoutOverlayState extends State<LogoutOverlay> {
  /* List<String> quan=new List<String>();
  List<String> unit=new List<String>();
  List imageurl=new List();
  List prod_price=new List();
  List item_name=new List();
  List item_quantity=new List();
  List item_units=new List();*/

  String textholder='1';
  int x1=1;
  int count=1;



  getposts() async{
    final Firestore _firestore = Firestore.instance;
    total=0;
    l.clear();
    quan.clear();
    unit.clear();
    imageurl.clear();
    prod_price.clear();
    item_name.clear();
    item_quantity.clear();
    item_units.clear();
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = await _auth.currentUser();

    QuerySnapshot qn = await firestore.collection('users').document(user.uid)
        .collection('cart').getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((f) => l.add('${f.data}'));
      u=snapshot.documents;
    });


    print("in cart page");
    print(l);

    //print(l[1].toString().split(': ')[1].split(',')[0]);
    //print(l.length);
    // l[j].toString().split(': ')[1].split(',')[0]
    ref = reference.child('Products').child('Bhubaneswar').child('Electronics');
    for (int j = 0; j < l.length; j++){
      reference.child('Products').child('Bhubaneswar').child('Electronics').child(
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


  cod(BuildContext context,String d)
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
            ),


          ],
        ),
        actions: <Widget>[
          MaterialButton(
            elevation:5.0,
            child: Text('Confirm'),
            onPressed: (){
              placeorder(d);
              sendmsg();

              Navigator.of(context).pop();
              Navigator.pop(context, MaterialPageRoute(builder: (context)=>new cart()));
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new orderconfirm()));





            },
          )
        ],
      );
    });
  }
  createAlertDialog(BuildContext context,String name,String pic,String price,String units,String id)
  {

    total=double.parse(price)*double.parse(units);
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
                  new Text("Quantity: "+units),
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
                    child: new Text("Total : ₹"+total.toString(),textAlign: TextAlign.end,),
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
                createAlertDialog1(context,name,id);

              },
            )
          ],
        ),
      );
    });
  }


  createAlertDialog1(BuildContext context,String n,String i)
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

              Container(
                height: 150.0,
                child: InkWell(
                  onTap: (){
                    getpredictions();

                  },
                  child:Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('${searchAddr}', maxLines: null,),

                  ),

                ),

                /* new TextField(
                    decoration: InputDecoration(
                        hintText: fadd.replaceAll(' ', '\n'),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: searchandNavigate,
                          iconSize: 30.0,
                        )
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) {
                      searchAddr = val;
                    },
                  ),*/
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
              setState(() {
                _text.text.isEmpty ? _validate = true : _validate = false;
                _text1.text.isEmpty ? _validate = true : _validate = false;
              });
              if(_text.text.isNotEmpty&&_text1.text.isNotEmpty){
                Navigator.of(context).pop();
                cod(context,i);
              }



            },
          )
        ],
      );
    });
  }
  Future<Null>refreshList() async{
    await Future.delayed(Duration(seconds: 2));
    getposts();
    setState(() {
      cart();


    });
    return null;
  }
  @override
  Widget build(BuildContext context) {
    //print("Textholder is");
    //print(count);
    int re;
    return new Scaffold(
      body:
      RefreshIndicator(
        onRefresh: refreshList,
        child: new ListView.builder(
          itemCount: l.length,
          itemBuilder: (BuildContext context,int index){
            //total_price+=double.parse(prod_price[index])*double.parse(units[index]);
            //return new Text(item_name[index]);
            return new Card(
              child: SingleChildScrollView(
                  child:ListTile(

                    leading:InkWell(
                        onTap: (){
                        },
                        child:
                        new Image.network(imageurl[index],width:100.0,height:400.0)
                    ),
                    title:new Text(item_name[index]),
                    subtitle: new Column(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),

                              child:new Text("Price : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                          ),
                          /*alignment: Alignment.topLeft,
                        child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                        ),
                        new Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),

                              child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                          ),
                          //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                        ),
                        new Row(
                          children: <Widget>[
                            new FlatButton(onPressed: (){
                              //createAlertDialog(context, name.split(': ')[1], imgurl, price.split(': ')[1]);

                              createAlertDialog(context,item_name[index],imageurl[index],prod_price[index],item_units[index],u[index].data["ProductId"]);
                            },
                                child:Text("Place Order")
                            ),
                            new FlatButton(
                                onPressed: (){
                                  //l[index].toString().split(': ')[1].split(',')[0]
                                  firestore.collection('users').document(user.uid).collection('cart').document(u[index].data["ProductId"]).delete();


                                  //refreshList();
                                  Navigator.pop(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));

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

  getpredictions() async{
    Prediction p = await PlacesAutocomplete.show(
        context: context, apiKey: "AIzaSyC52Z3z1WF_y0Q0dbYfexizoexgAnSTov0");
    displayPrediction(p);
  }
  Future<String> displayPrediction(Prediction p) async {
    String x;
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);
      print("Address is");
      final coordinates=new Coordinates(lat,lng);
      var addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first=addresses.first;
      //print("${first.featureName}:${first.addressLine}");
      x=first.addressLine;
      print(lat);
      print(lng);
      searchAddr="${first.addressLine}";
      print(searchAddr);






      searchandNavigate(x);
    }
  }

  placeorder(String item_id) async{
    FirebaseDatabase.instance.reference().child('Orders').child(user.uid).push().set(
        {
          'Address':searchAddr,
          'buyer':custname,
          'location':lat.toString()+","+lon.toString(),
          'phone':custphone,
          'prodcat':'electronics',
          'productid':item_id,
          //'units':units,
          'price':total,
        }



    );
    /*await launch(
        "https://wa.me/${919439200913}?text=Hello");
    print("hi");*/

  }



}
sendmsg()async {
  await launch(
      "https://wa.me/${919439200913}?text=Order Received for user id ${user.uid}");
  print("message");

}
void onMapCreated(GoogleMapController controller) {
  mapController=controller;
  _markers.clear();
  final marker = Marker(
      onTap: (){
        //print('Tapped');
      },
      draggable: true,
      markerId: MarkerId("curr_loc"),
      position: LatLng(21.5007, 83.8995),

      infoWindow: InfoWindow(title: 'Your Location'),
      onDragEnd: ((value) async {
        // print(value.latitude);
        //print(value.longitude);
      })
  );
  _markers["Current Location"] = marker;
}

//setMarker() {}

void searchandNavigate(String s) {
  Geolocator().placemarkFromAddress(s).then((result) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target:
        LatLng(result[0].position.latitude, result[0].position.longitude),
            zoom: 15)));




    _markers.clear();
    final marker = Marker(
        onTap: (){
          //print('Tapped');
        },
        draggable: true,
        markerId: MarkerId("curr_loc"),
        position: LatLng(result[0].position.latitude, result[0].position.longitude),

        infoWindow: InfoWindow(title: 'Your Location'),
        onDragEnd: ((value) async {


          // print(value.latitude);
          // print(value.longitude);
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