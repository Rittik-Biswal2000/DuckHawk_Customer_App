  import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_database/firebase_database.dart';
  import 'package:firebase_storage/firebase_storage.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/model/Orders.dart';
import 'package:project_duckhawk/model/Products.dart';
import 'package:project_duckhawk/model/loc.dart';
import 'package:project_duckhawk/pages/orderconfirm.dart';
import 'package:project_duckhawk/src/welcomPage.dart';
import 'package:cloud_functions/cloud_functions.dart';
  import 'package:http/http.dart' as http;

  import '../main.dart';
  import 'cart.dart';
import 'cart1.dart';
 // String prod_id;
  class item_info extends StatefulWidget {
    String id;
    String image;
    String n;
    String p;
    String des;
    String q;
    String curse;
    String cat;
    item_info(
      this.curse,this.cat,this.id,this.image,this.n,this.p,this.des,this.q);


    @override
    _item_infoState createState() => _item_infoState();
  }
  class Item {
    const Item(this.name,this.icon);
    final String name;
    final Icon icon;
  }

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyC52Z3z1WF_y0Q0dbYfexizoexgAnSTov0");
  double total=0;
  String custname,custphone;
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  bool _validate = false;
  ProgressDialog pr;

  List<String> quan=[];
  String _dropDownValue="Quantity";
  String units="1";
  String _selectedLocation = 'Please choose a location';
  String p='pro4.jpg';
  String seller,imgurl,quantity,price="loading",name="Loading",description,uadd,fadd;
  double lat,lon;
  DatabaseReference ref;
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  String searchAddr;
  FirebaseUser user;
getpoint(String s)async{
  //final query = fadd;
  var addresses = await Geocoder.local.findAddressesFromQuery(s);
  var first = addresses.first;
  lat=first.coordinates.latitude;
  lon=first.coordinates.longitude;
  print("${first.featureName} : ${first.coordinates}");
}
  class _item_infoState extends State<item_info> {

    //var _firebaseRef = FirebaseDatabase().reference().child('Products').child('Electronics');
    final FirebaseStorage storage = FirebaseStorage(
        app: Firestore.instance.app,
        storageBucket: 'gs://duckhawk-1699a.appspot.com');

    Uint8List imageBytes;
    String errorMsg;

    image() {
      storage.ref().child(p).getData(10000000).then((data) =>
          setState(() {
            imageBytes = data;
          })
      ).catchError((e) =>
          setState(() {
            errorMsg = e.error;
          })
      );
    }
  void initState(){
      super.initState();


      getuser();



  }

  getuser()async{
      await getquanlist();
      user= await FirebaseAuth.instance.currentUser();
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


  }
    cod(BuildContext context)
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
                placeorder();
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new orderconfirm()));


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
    @override
    Widget build(BuildContext context) {
      pr = new ProgressDialog(context, showLogs: true);
      pr.style(message: 'Please wait...');
      image();
      var img = imageBytes != null ? Image.memory(
        imageBytes,
        fit: BoxFit.cover,
      ) : Text(errorMsg != null ? errorMsg : "Loading...");

      return new Scaffold(
          appBar: new AppBar(
              backgroundColor: Color(0xff104670),
            title: new Text(widget.n),
              actions: <Widget>[
          // action button
          IconButton(icon:Icon(Icons.shopping_cart),
        onPressed: () async{
          await getcartData();
        },
      ),
            ]
            //title: new Text(name.split(': ')[1]),
          ),
        body:
        ListView(
          children: <Widget>[
            new Container(
              height: 300.0,
              child: GridTile(
                child: Container(
                  color: Colors.white,
                  child: Image.network(widget.image),
                ),
              ),
            ),



            Row(

              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: new Container(
                    child: new Text(widget.n+"\n"+"₹"+widget.p),
                    //child: new Text(name.split(': ')[1]+"\n"+"₹"+price.split(': ')[1]),
                  ),
                ),
      ],
            ),
      Row(children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(16.0,0,4.0,0),
          child: DropdownButton<String>(

              items: quan.map((String val) {
                return new DropdownMenuItem<String>(
                  value: val,
                  child: new Text(val),
                );
              }).toList(),
              hint: Text("Quantity",
                style: TextStyle(color: Colors.blue),
              ),
              onChanged: (val) {
                //_selectedLocation = newVal;
                setState(() {
                  _dropDownValue=val;
                  units=_dropDownValue;
                });
              }),
        ),

      ],),











            Row(

              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                ),
                new Text("Units : "+units),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child:MaterialButton(
                    onPressed:(quantity!='0')? (){
                      /*addtocart();
                      Navigator.push(context,MaterialPageRoute(builder:(context)=>new cart()));*/

                      createAlertDialog(context, widget.n, widget.image, widget.p);
                      //Navigator.pop(context);
                    }:null,
                    color:Colors.redAccent,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child:new Text("Buy Now"),
                  ),
                ),
                new IconButton(icon:Icon(Icons.add_shopping_cart),onPressed: ()async{
                  pr.show();
                  await addtocart();
                  pr.hide();
                  Fluttertoast.showToast(
                      msg: "Added to cart",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 8.0
                  );

                  //Navigator.push(context,MaterialPageRoute(builder:(context)=>new cart1()));
                }),
                //new IconButton(icon:Icon(Icons.favorite),onPressed: (){}),
              ],
            ),
            Divider(),
            new ListTile(
              title:new Text("Product Details"),
              subtitle: new Text(widget.des),
              //subtitle: new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            )
          ],

        ),

  );

  }

    Future<void> addtocart() async {
      DocumentReference ref,ref1;
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final Firestore _firestore = Firestore.instance;
      FirebaseUser user = await _auth.currentUser();
      ref = _firestore.collection('users').document(user.uid);
     // print("hi");
      ref1=ref.collection('cart').document();
      //print(ref.documentID);

      await ref.collection('cart').document(loc).collection(widget.curse).document(widget.id).setData({
        'ProductId':widget.id,
        'category':widget.cat,
        'city':loc,
        'price':widget.p,
        'seller':widget.curse,
        'quantity':units,
      });


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

  placeorder() async {
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
    Orders todo = new Orders(loc, user.uid, widget.curse, time, double.parse(widget.p));
    Products prod = new Products(widget.id, widget.cat, loc, double.parse(widget.p), double.parse(widget.q), widget.curse);
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
      await _database.reference().child("Orders").child(loc).child(y).child("Products").child(widget.id).set(prod.toJson());
      await _database.reference().child("Orders").child(loc).child(y).child("location").set(loc1.toJson());
    }
//  todo.completed = true;
//  if (todo != null) {
//    _database.reference().child("Todo").child("Bhubaneswar").set(todo.toJson());
//  }
    print("hello data added in firebase");

  }

  getquanlist() {
    var x = int.parse(widget.q);
    print(x.runtimeType);
    quan.clear();

    while(x!=0){
      quan.add((x--).toString());
    }
    print(quan);
  }
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
  getcartData() async{
  FirebaseUser user=await FirebaseAuth.instance.currentUser();
  print("cloud functions");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getSubCollections',
    );
    //dynamic resp = await callable.call();
    dynamic resp = await callable.call(<String, dynamic>{
      'docPath': '/users/${user.uid}/cart/${loc}/',
    });
    //print(resp.data);
    //print(resp.data.toString().split(': ')[1].split(', '));
    List suid=[];
    //print(resp.data.toString().split(': ')[1].split(', ')[3]);
    for(var i=0;i<resp.data.toString().split(': ')[1].split(', ').length;i++)
      {
        var xs;
        if(i==0)
          {
            var sl=resp.data.toString().split(': ')[1].split(', ')[i].length;
            xs=resp.data.toString().split(': ')[1].split(', ')[i].substring(1,sl);
          }
        else if(i==(resp.data.toString().split(': ')[1].split(', ').length)-1)
        {
          var sl=resp.data.toString().split(': ')[1].split(', ')[i].length;
          xs=resp.data.toString().split(': ')[1].split(', ')[i].substring(0,sl-2);
        }
        else
          xs=resp.data.toString().split(': ')[1].split(', ')[i];
        //int l=xs.toString().length;
        
        suid.add(xs);
      }
    print(suid[0]);
  print(suid[1]);
  print(suid[2]);
  print(suid[3]);
  dynamic resp1 = await callable.call(<String, dynamic>{
    'docPath': '/users/${user.uid}/cart/${loc}/${suid[2].toString()}/',
  });
  print(resp1.data.toString());

  }
