  import 'dart:typed_data';

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_database/firebase_database.dart';
  import 'package:firebase_storage/firebase_storage.dart';
  import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_duckhawk/pages/orderconfirm.dart';
import 'package:project_duckhawk/shared/loading.dart';

  import '../main.dart';
  import 'cart.dart';
 // String prod_id;
  class item_info extends StatefulWidget {
    String product_id;
    item_info(
      this.product_id,);


    @override
    _item_infoState createState() => _item_infoState();
  }
  String p='pro4.jpg';
  String seller,imgurl,quantity,price="loading",name="Loading",description,uadd,fadd;
  double lat,lon;
  DatabaseReference ref;
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  String searchAddr;
  FirebaseUser user;
getpoint()async{
  final query = fadd;
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
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
      DatabaseReference reference=FirebaseDatabase.instance.reference();
      reference.child('Products').child('Electronics').child(widget.product_id).once().then((DataSnapshot snap){
        var keys=snap.value.keys;
        print("The keys are :"+keys.toString());
        var data=snap.value;
        print("The data is :"+data.toString());
        //print(data.toString().split(',')[1]);
        seller=data.toString().split(',')[0];
        imgurl=data.toString().split(',')[1];
        quantity=data.toString().split(',')[2];
        price=data.toString().split(',')[3];
        name=data.toString().split(',')[4];
        description=data.toString().split(',')[5];
        print(seller+"\n"+imgurl+"\n"+quantity+"\n"+price+"\n"+name+"\n"+description);
        imgurl=imgurl.split(': ')[1];
        quantity=quantity.split(': ')[1];
        print("Quantity");
        print(quantity);
        firestore
            .collection("users").where("uid", isEqualTo: user.uid)
            .getDocuments()
            .then((QuerySnapshot snapshot) {

          snapshot.documents.forEach((f) => uadd = '${f.data}');
          print("Address is:");
          print(uadd.split(',')[2].split(': ')[1]);
          fadd=uadd.split(',')[2].split(': ')[1];
          searchAddr=fadd.replaceAll(' ', '\n');

        });


      });

  }
  getuser()async{
      user= await FirebaseAuth.instance.currentUser();
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
    createAlertDialog(BuildContext context,String name,String pic,String price)
    {
      print("in 1st dialog box");
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
                  Image.network(pic,width:100.0,height:200.0),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("Quantuty: "+quantity),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
    @override
    Widget build(BuildContext context) {
      /*getData().then((val){
        print('Value is');
        print(val.price);
      });*/
      image();
      var img = imageBytes != null ? Image.memory(
        imageBytes,
        fit: BoxFit.cover,
      ) : Text(errorMsg != null ? errorMsg : "Loading...");

      return new Scaffold(
          appBar: new AppBar(
            title: new Text(name.split(': ')[1]),
          ),
        body:
        ListView(
          children: <Widget>[
            new Container(
              height: 300.0,
              child: GridTile(
                child: Container(
                  color: Colors.white,
                  child: Image.network(imgurl),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: new Container(
                    child: new Text(name.split(': ')[1]+"\n"+price.split(': ')[1]),
                  ),
                ),

                /*Expanded(
                  child: Row(
                    children: <Widget>[
                      DropdownButton<List>(

                      ),
                    ],
                  ),

                  child:MaterialButton(onPressed: (){},
                    color:Colors.white,
                    textColor: Colors.grey,
                    elevation:0.2,
                    child:Row(
                      children: <Widget>[
                        Expanded(
                            child: new Text("Quantity"),

                        ),
                        /*Expanded(
                            //child: new Icon(Icons.arrow_drop_down)
                        ),*/

                      ],
                    ),
                  ),
                ),*/


              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child:MaterialButton(
                    onPressed:()  {
                      /*addtocart();
                      Navigator.push(context,MaterialPageRoute(builder:(context)=>new cart()));*/
                      createAlertDialog(context, name.split(': ')[1], imgurl, price.split(': ')[1]);
                    },
                    color:Colors.redAccent,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child:new Text("Buy Now"),
                  ),
                ),
                new IconButton(icon:Icon(Icons.add_shopping_cart),onPressed: (){
                  addtocart();
                  Navigator.push(context,MaterialPageRoute(builder:(context)=>new cart()));
                }),
                new IconButton(icon:Icon(Icons.favorite),onPressed: (){}),
              ],
            ),
            Divider(),
            new ListTile(
              title:new Text("Product Details"),
              subtitle: new Text(description.split(': ')[1]),
              //subtitle: new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            )
          ],

        ),

  );

        /*body: ListView(
          children: <Widget>[
            new Container(
              height: 300.0,
              child: GridTile(
                child: Container(
                  color: Colors.white,
                  child: img,
                ),
                footer: new Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: new Text("Abc",
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                    title:new Row(
                      children: <Widget>[
                        Expanded(
                          child:new Text("2000"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child:MaterialButton(onPressed: (){},
                    color:Colors.white,
                    textColor: Colors.grey,
                    elevation:0.2,
                    child:Row(
                      children: <Widget>[
                        Expanded(
                            child: new Text("Quantity")
                        ),
                        Expanded(
                            child: new Icon(Icons.arrow_drop_down)
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child:MaterialButton(
    onPressed:()  {
    addtocart();
    Navigator.push(context,MaterialPageRoute(builder:(context)=>new cart()));
    },
    color:Colors.redAccent,
    textColor: Colors.white,
    elevation: 0.2,
    child:new Text("Buy Now"),
    ),
    ),
    new IconButton(icon:Icon(Icons.add_shopping_cart),onPressed: (){}),
    new IconButton(icon:Icon(Icons.favorite),onPressed: (){}),
    ],
    ),
    Divider(),
    new ListTile(
    title:new Text("Product Details"),
    subtitle: new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    )
    ],

    ),*/
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

      ref.collection('cart').document(widget.product_id).setData({
        'ProductId':widget.product_id,
        'category':'electronics'
      });
      /*

      Firestore.instance.collection('/users').document().collection('/Carts').add({
        'prod_pic':widget.prod_pic,
        'prod_name':widget.prod_name,
        'prod_price':widget.prod_price


      });*/
    }

    getData() async{/*
      DatabaseReference re;
     // re.child('Products\Electronics\-LxGRP0DOWjWX1m0gVq').once().then((DataSnapshot data){
        //print(data.value);
        //print(data.key);
      }
      );
      return re;*/
    }
  }
  void onMapCreated(GoogleMapController controller) {

    getpoint();
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
        position: LatLng(lat,lon),
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
