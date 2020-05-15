import 'dart:async';
import 'dart:collection';
import 'dart:convert';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/model/Orders.dart';
import 'package:project_duckhawk/model/Products.dart';
import 'package:project_duckhawk/model/loc.dart';
import 'package:project_duckhawk/pages/electronics.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/pages/orderconfirm.dart';
import 'package:project_duckhawk/src/welcomPage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
class cart1 extends StatefulWidget {
  @override
  _cart1State createState() => _cart1State();
}

class _cart1State extends State<cart1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body:Center(
        child: DelayedList(),

      ),
      bottomNavigationBar: new Container(
          color:Colors.white,
          child:Row(
            children: <Widget>[
              Expanded(
                  child:ListTile(
                    title:new Text("Total Amount :"),
                    subtitle:new Text("Total - "+ctotal.toString()),
                  )
              ),
              Expanded(
                  child:new FlatButton(onPressed: (){
                    //createAlertDialog1(context," others");
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
class DelayedList extends StatefulWidget {
  @override
  _DelayedListState createState() => _DelayedListState();
}
GoogleMapController mapController;
final Map<String, Marker> _markers = {};
class _DelayedListState extends State<DelayedList> {
  bool isLoading=true;



  @override
  Widget build(BuildContext context)  {
    Timer timer=Timer(Duration(seconds: 2),(){
      setState(() {
        isLoading=false;
      });
    });
    return isLoading?ShimmerList():DataList(timer);
  }
}
final _text = TextEditingController();
final _text1 = TextEditingController();
bool _validate = false;
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyC52Z3z1WF_y0Q0dbYfexizoexgAnSTov0");
class DataList extends StatelessWidget {
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  String searchAddr;


  final Timer timer;
  DataList(this.timer);
  cod(BuildContext context,String n,String c,String p,String pr,String q,String i,String s)
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
            child: Text('Conform'),
            onPressed: (){
              placeorder(n,c,p,pr,q,i,s);
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new orderconfirm()));


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
              ),


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
  createAlertDialog(BuildContext context,String name,String cat,String pic,String price,String quantity,String id,String seller)
  {

    total=double.parse(price)*double.parse(quantity);
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
                    child: new Text("Total : ₹"+price.toString(),textAlign: TextAlign.end,),
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
                //Navigator.of(context).pop();
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
    timer.cancel();
    return ListView.builder(
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
                          new FlatButton(onPressed: (){




                            createAlertDialog(context,cname[index],'Electronics',cimage[index],cprice[index],cquantity[index],cid[index],cseller[index]);
                          },
                              child:Text("Place Order")
                          ),
                          new FlatButton(
                              onPressed: (){
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

        });
  }



}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset=0;
    int time=800;
    return SafeArea(
      child: ListView.builder(
        itemCount: 6,
          itemBuilder:(BuildContext context,int index) {
          offset+=5;
          time=800+offset;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Shimmer.fromColors(highlightColor:Colors.white,baseColor: Colors.grey,child: ShimmerLayout(),
            period:Duration(milliseconds: time),),
          );
          }),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerwidth=200;
    double containerHeight=50;
    return Container(
      margin:EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 100,
            width:80,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: containerHeight,
                width: containerwidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerwidth*0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}

/*getpredictions() async{
  Prediction p = await PlacesAutocomplete.show(
      context: context, apiKey: "AIzaSyC52Z3z1WF_y0Q0dbYfexizoexgAnSTov0");
  displayPrediction(p);
}*/
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

placeorder(String name,String cat,String pic,String price,String q,String id,String seller) async {
  FirebaseUser user=await FirebaseAuth.instance.currentUser();
  DatabaseReference _database=FirebaseDatabase.instance.reference();
  var now = new DateTime.now();
  //print(now.millisecondsSinceEpoch);
  var d=new DateFormat("dd-MM-yyyy").format(now);
  var t=new DateFormat("H:m:s").format(now);
  String time=d.toString()+" "+t.toString();
  print(currrentseller);/*
    //print(new DateFormat("yyyy/MM/dd", "en_US").parse(DateFormat("dd-MM-yyyy").format(now)));

    FirebaseDatabase.instance.reference().child('Orders').child(loc).push().set({

      'Address':searchAddr,
      'total':widget.p,
      'buyer':user.uid,
      'time':time,
      'seller':widget.curse,


    });*/
  Orders todo = new Orders(loc, user.uid,seller, time, double.parse(price));
  Products prod = new Products(id, cat, loc, double.parse(price), double.parse(q), seller);
  locs loc1 = new locs(20.4571, 85.9999);
  await _database.reference().child("Orders").child(loc).push().set(todo.toJson());
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
  }
//  todo.completed = true;
//  if (todo != null) {
//    _database.reference().child("Todo").child("Bhubaneswar").set(todo.toJson());
//  }
  print("hello data added in firebase");

}
void onMapCreated(GoogleMapController controller) {

  //getpoint();
  print(lat.toString());
  print(lon.toString());

  mapController=controller;
  _markers.clear();
  final marker = Marker(
      onTap: (){
        print('Tapped');
      },
      draggable: true,
      markerId: MarkerId("curr_loc"),
      position: LatLng(double.parse(curlat),double.parse(curlon)),
      //position: LatLng(21.5007, 83.8995),

      infoWindow: InfoWindow(title: 'Your Location'),
      onDragEnd: ((value) async {
        print(value.latitude);
        print(value.longitude);
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