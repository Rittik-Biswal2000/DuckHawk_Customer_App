import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
class Cart_Products extends StatefulWidget {
  final c_p_pic;
  final c_p_name;
  final c_p_price;


  Cart_Products(this.c_p_pic, this.c_p_name, this.c_p_price);

  @override
  _Cart_ProductsState createState() => _Cart_ProductsState();
}

class _Cart_ProductsState extends State<Cart_Products> {
  var Products_on_the_cart=[
    {
      "name": "Blazer1",
      "picture": "images/download.png",
      "price": "₹2500",
      "Quantity" :1
    },
    {
      "name": "Blazer2",
      "picture": "images/download (1).png",
      "price": "₹2600",
      "Quantity" :2
    },
    {
      "name": "Blazer3",
      "picture": "images/download (2).png",
      "price": "₹2400",
      "Quantity" :3
    },
    {
      "name": "Blazer4",
      "picture": "images/download (4).png",
      "price": "₹2300",
      "Quantity" :4
    },
    {
      "name": "Blazer5",
      "picture": "images/download (4).png",
      "price": "₹2200",
      "Quantity" :5
    },
    {
      "name": "Blazer6",
      "picture": "images/download (4).png",
      "price": "₹2000",
      "Quantity" :6
    },
  ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: Products_on_the_cart.length,
        itemBuilder: (context,index){
        return Single_cart_product(
          cart_prod_name: Products_on_the_cart[index]["name"],
          cart_prod_price: Products_on_the_cart[index]["price"],
          cart_prod_qty: Products_on_the_cart[index]["Quantity"],
          cart_prod_picture: Products_on_the_cart[index]["picture"],
        );

        });
  }
}


class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_qty;
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  //final String searchAddr;

  Single_cart_product({
      this.cart_prod_name, this.cart_prod_picture,
      this.cart_prod_price, this.cart_prod_qty});


  createAlertDialog(BuildContext context)
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
                Center(child: Text(cart_prod_name),)
                //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(cart_prod_picture),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("Quantuty: $cart_prod_qty\n"),
                new Text("Price: $cart_prod_price",textAlign: TextAlign.end,),
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
              createAlertDialog1(context);

            },
          )
        ],
      );
    });
  }

String searchAddr;
  createAlertDialog1(BuildContext context)
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
                  Center(child: Text(cart_prod_name),)
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

  @override
  Widget build(BuildContext context) {
    return Card(

      child:SingleChildScrollView(
        child: ListTile(
          leading: new Image.asset(cart_prod_picture,width:100.0,height:400.0),
          title: new Text(cart_prod_name),
          subtitle: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,0.0,5.0,2.0),
                    child: new Text("Quantity"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,0.0,5.0,2.0),
                    child:new Text("$cart_prod_qty"),
                  ),
                  new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
                  new Text("$cart_prod_qty"),
                  new IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){}),



                ],

              ),
              new Container(
                alignment: Alignment.topLeft,
                child:new Text("${cart_prod_price}",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
              ),
              new Row(
                children: <Widget>[
                  new FlatButton(onPressed: (){
                    createAlertDialog(context);
                  },
                      child: Text("Place Order")),
                  new FlatButton(onPressed: (){}, child: Text("Delete")),
                ],
              ),

            ],
          ),
         /* trailing: new Column(
            children: <Widget>[
              new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
              new Text("$cart_prod_qty"),
              new IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){}),
            ],
          ),*/
        ),
      ),
    );
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
}


