import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';


import '../main.dart';

class olocation extends StatefulWidget {
  @override
  _olocationState createState() => _olocationState();
}
var v3,v4;
var latitude1,longitude1;
var plat,plon;
class _olocationState extends State<olocation> {
  Position _currentPosition;
  String lat,lon,v1,v2,add;

  var addresses;
  var first;
  var ab;
  //List<Marker> allMarkers = [];
  final Map<String, Marker> _markers = {};

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyCcH5Qy8dTYdMNvQ8ufSzW9wpHY2qGhFK4");


  @override
  void initState() {
    super.initState();

    _markers.clear();
    storecoordinates(curlat, curlon);
    final marker = Marker(
        draggable: true,
        markerId: MarkerId("curr_loc"),
        // position: LatLng(21.5007,83.8994),
        position: LatLng(double.parse(curlat),double.parse(curlon)),
        infoWindow: InfoWindow(title: 'Your Location'),
        onDragEnd: ((value) async {
          v3=value.latitude;
          v4=value.longitude;
          print(value.latitude);
          print(value.longitude);
          latitude1=value.latitude;
          longitude1=value.longitude;
          final coordinates=new Coordinates(v3,v4);
          addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
          first=addresses.first;
          print("${first.featureName}:${first.addressLine}");
        })
    );
    _markers["Current Location"] = marker;
    //_getAddressFromLatLng(21.5007,83.8994);
    _getAddressFromLatLng(double.parse(curlat),double.parse(curlon));
  }

  GoogleMapController mapController;
  String searchAddr="Search here";

  @override
  Widget build(BuildContext context) {
    //getpredictions();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Stack(

          children: <Widget>[


            //height: 300.0,


            GoogleMap(

              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                // target: LatLng(21.5007, 83.8995),
                target: LatLng(double.parse(curlat),double.parse(curlon)),
                zoom: 15.0,),
              markers: _markers.values.toSet(),

            ),
            Positioned(
              top: 30.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),

                child: InkWell(
                  onTap: (){
                    getpredictions();

                  },
                  child:Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(searchAddr),
                  ),

                ),
              ),
            ),
            Positioned(
              bottom: 30.0,
              right: 15.0,
              left: 15.0,
              child: new RaisedButton(
                onPressed: (){
                  Confirm();
                },
                textColor: Colors.white,
                color: Colors.red,
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Confirm Location and update",
                ),
              ),


            )


          ],
        ),
      ),
    );


  }

  searchandNavigate(String s) {


    Geolocator().placemarkFromAddress(s).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target:
          LatLng(result[0].position.latitude, result[0].position.longitude),
              zoom: 15)));

      _getAddressFromLatLng(result[0].position.latitude, result[0].position.longitude);
      setState(() {

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

              v3=value.latitude;
              v4=value.longitude;
              latitude1=value.latitude;
              longitude1=value.longitude;
              print(value.latitude);
              print(value.longitude);
              final coordinates=new Coordinates(v3,v4);
              addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
              first=addresses.first;
              add=first.addressLine;
              print("${first.featureName}:${first.addressLine}");
              storecoordinates(v3, v4);
            })
        );
        _markers["Current Location"] = marker;
        //_getAddressFromLatLng(v3,v4);
      });

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

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
  void Address() {
    _getAddressFromLatLng(v3, v4);
  }
  _getAddressFromLatLng(v3, v4)  async {
    latitude1=v3;
    longitude1=v4;
    final coordinates=new Coordinates(v3,v4);
    addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first=addresses.first;
    print("${first.featureName}:${first.addressLine}");


  }

  void Confirm() async{
    Navigator.pop(context);
    //  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProduct(first.locality)));
    //final c=new Coordinates(plat,plon);
    // List<Placemark> placemark = await Geolocator().placemarkFromAddress(addresses.toString());
    //print(placemark.toString());
    //print('Coordinates are :');
    //print(c.toString());
    print(latitude1);
    print(longitude1);
    //Navigator.push(context, MaterialPageRoute(builder: (context)=> item_info(null,null,null,null,null,null,null,null,null,latitude1.toString(),longitude1.toString())));
    //Navigator.pushReplacementNamed(context, MaterialPageRoute(builder: (context)=> HomePage(first.addressLine)));
  }

  getpredictions() async{
    Prediction p = await PlacesAutocomplete.show(
        context: context, apiKey: "AIzaSyCcH5Qy8dTYdMNvQ8ufSzW9wpHY2qGhFK4");
    displayPrediction(p);

  }


  /*Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

       searchAddr = (await Geocoder.local.findAddressesFromQuery(p.description)) as String;

      print(lat);
      print(lng);
      //_getAddressFromLatLng(lat, lng);
      searchandNavigate();
    }
  }*/

  Future<String> displayPrediction(Prediction p) async {
    String x;
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      plat = detail.result.geometry.location.lat;
      plon = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);
      print("Address is");
      final coordinates=new Coordinates(plat,plon);
      addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
      first=addresses.first;
      //print("${first.featureName}:${first.addressLine}");
      x=first.addressLine;
      searchAddr="${first.addressLine}";
      storecoordinates(plat, plon);






      searchandNavigate(x);
    }
  }





}



/*
class MyLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  Position _currentPosition;
  String lat,lon,v1,v2,add;
  var v3,v4;
  var addresses;
  var first;
  var ab;
  //List<Marker> allMarkers = [];
  final Map<String, Marker> _markers = {};

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyC52Z3z1WF_y0Q0dbYfexizoexgAnSTov0");


  @override
  void initState() {
    super.initState();
    _markers.clear();
    final marker = Marker(
        draggable: true,
        markerId: MarkerId("curr_loc"),
        // position: LatLng(21.5007,83.8994),
        position: LatLng(double.parse(curlat),double.parse(curlon)),
        infoWindow: InfoWindow(title: 'Your Location'),
        onDragEnd: ((value) async {
          v3=value.latitude;
          v4=value.longitude;
          print(value.latitude);
          print(value.longitude);
          final coordinates=new Coordinates(v3,v4);
          addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
          first=addresses.first;
          print("${first.featureName}:${first.addressLine}");
        })
    );
    _markers["Current Location"] = marker;
    //_getAddressFromLatLng(21.5007,83.8994);
    _getAddressFromLatLng(double.parse(curlat),double.parse(curlon));
  }

  GoogleMapController mapController;
  String searchAddr;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Stack(

          children: <Widget>[


            //height: 300.0,


            GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                // target: LatLng(21.5007, 83.8995),
                target: LatLng(double.parse(curlat),double.parse(curlon)),
                zoom: 15.0,),
              markers: _markers.values.toSet(),

            ),
            Positioned(
              top: 30.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextField(
                  /*onTap: ()async{
                    Prediction p=await PlacesAutocomplete.show(context: context,
                        apiKey: "AIzaSyC52Z3z1WF_y0Q0dbYfexizoexgAnSTov0",
                    mode:Mode.overlay,
                    language: "en",
                    components: [new Component(Component.country, "in"),searchandNavigate()]);
                    //displayPrediction(p);
                    /*if(p!=null) {
                      PlacesDetailsResponse detail = await _places
                          .getDetailsByPlaceId(p.placeId);
                      var placeId = p.placeId;
                      double lt=detail.result.geometry.location.lat;
                      double ln=detail.result.geometry.location.lng;
                      var adress = await Geocoder.local.findAddressesFromQuery(
                          p.description);
                      print(adress);
                      print(lt);
                      print(ln);
                    }*/


                    //searchandNavigate();
                    //searchAddr=p as String;
                    //displayPrediction(p);
                    // searchAddr = (await Geocoder.local.findAddressesFromQuery(p.description)) as String;
                  },*/
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    hintText: 'Enter address',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: searchandNavigate,
                      iconSize: 30.0,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      searchAddr = val;
                    });
                  },

                ),
              ),
            ),
            Positioned(
              bottom: 30.0,
              right: 15.0,
              left: 15.0,
              child: new RaisedButton(
                onPressed: (){
                  Confirm();
                },
                textColor: Colors.white,
                color: Colors.red,
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Confirm Location and update",
                ),
              ),


            )


          ],
        ),
      ),
    );


  }

  searchandNavigate() {


    Geolocator().placemarkFromAddress(searchAddr).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target:
          LatLng(result[0].position.latitude, result[0].position.longitude),
              zoom: 15)));

      _getAddressFromLatLng(result[0].position.latitude, result[0].position.longitude);
      setState(() {

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

              v3=value.latitude;
              v4=value.longitude;
              print(value.latitude);
              print(value.longitude);
              final coordinates=new Coordinates(v3,v4);
              addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
              first=addresses.first;
              add=first.addressLine;
              print("${first.featureName}:${first.addressLine}");
            })
        );
        _markers["Current Location"] = marker;
        //_getAddressFromLatLng(v3,v4);
      });

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

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
  void Address() {
    _getAddressFromLatLng(v3, v4);
  }
  _getAddressFromLatLng(v3, v4)  async {
    final coordinates=new Coordinates(v3,v4);
    addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first=addresses.first;
    print("${first.featureName}:${first.addressLine}");


  }

  void Confirm() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>new AddProduct(first.locality)));
  }


/*Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

       searchAddr = (await Geocoder.local.findAddressesFromQuery(p.description)) as String;

      print(lat);
      print(lng);
      //_getAddressFromLatLng(lat, lng);
      searchandNavigate();
    }
  }

*/



}


*/
storecoordinates(var la,var lo){
  latitude1=la;
  longitude1=lo;


}