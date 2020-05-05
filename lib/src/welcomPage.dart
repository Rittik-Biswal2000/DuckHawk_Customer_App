import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:ffi';

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/src/loginPage.dart';
import 'package:project_duckhawk/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_duckhawk/pages/login_page.dart';
import 'package:http/http.dart' as http;


import 'package:project_duckhawk/src/signup.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}
FirebaseUser user;
ProgressDialog pr;
var a,b,loc;
List seller=[];
List sellerlist=[];
List fdistance=[];
List fowner_name=[];
List fowner_phone=[];
List imgurl=[];
List quantity=[];
List price=[];
List name=[];
List description=[];
List l=[];
List prod_id=[];
List prod_cat=[];
List distance=[];
var len;
String badd="Loading";
List se=[];
List se_name=[];
List se_phone=[];
List owner_name=[];
List owner_phone=[];
var n;
var length;
int j;
final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

Position _currentPosition;
String _currentAddress ;
String na="Login/SignUp";
FirebaseUser mCurrentUser;
FirebaseAuth _auth;


int d=0;
String add="hi";
class _WelcomePageState extends State<WelcomePage> {

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => lp()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xff104670).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color(0xff104670)),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }


  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'DuckHawk',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [/*
            TextSpan(
              text: 'kHa',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'wk',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          */]),
    );
  }
  @override
  void initState() {
    getcurrentlocation();
    // getseller();

    getuser();
    //getData();
    //getproducts();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff104670), Color(0xff104672)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 80,
              ),
              _submitButton(),
              SizedBox(
                height: 20,
              ),
              _signUpButton(),
              SizedBox(
                height: 20,
              ),
              //_label()
            ],
          ),
        ),
      ),
    );
  }

  getuser() async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    if(user.uid!=null)
    {
      Fluttertoast.showToast(
          msg: "Welcome "+user.email,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          //backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 8.0
      );

    }

    pr.show();
    loc=await _getCurrentLocation();
    await getData(loc);
    pr.hide();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(null)),
    );
    //Navigator.pop(context);


  }

  getcurrentlocation() {
    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    d++;
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      curlat = _currentPosition.latitude.toString();
      curlon = _currentPosition.longitude.toString();
      print("Coordinates are :");

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}";
        print(place.locality);
      });


      badd = _currentAddress;
      print("badd is:");
      print(badd);
    } catch (e) {
      print(e);
    }
  }
}

Future<String>_getCurrentLocation() async{
  var p;
  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager;

  await geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) async {
    _currentPosition = position;
    a=position.latitude;
    b=position.longitude;
    p=await _getAddressFromLatLng();
    /*setState(() {
    });*/
    //
  }).catchError((e) {
    print(e);
  });

  //print("p is :"+'${p}');
  return p;
}
Future getData(String x) async {
  var lati,longi;
  //var x=await _getCurrentLocation();
  owner_name.clear();
  owner_phone.clear();
  fdistance.clear();
  fowner_name.clear();
  fowner_phone.clear();
  distance.clear();
  prod_id.clear();
  List list;
  String link = "https://duckhawk-1699a.firebaseio.com/Seller/"+loc+".json";
  final resource = await http.get(link);
  if (resource.statusCode == 200) {
    // print(resource.body);
    //var data = jsonDecode(resource.body)["Cuttack"];
    LinkedHashMap<String, dynamic> data = jsonDecode(resource.body);
//    Iterator hmIterator = data.entrySet().iterator();
//    while (hmIterator.hasNext()) {
//      Map.Entry mapElement = (Map.Entry)hmIterator.next();
//      int marks = ((int)mapElement.getValue() + 10);
//      print(mapElement.get)
//  }
//    var list = new List<int>.generate(data.length, (i) => i + 1);
    List list = data.keys.toList();
    length=list.length;
    print('Seller list');
    for(var i=0;i<length;i++)
      {
        sellerlist.add(list[i]);
      }
    print(sellerlist);

    //  print(data[list[3]]);

    int h=0;
    while(h<list.length) {
      LinkedHashMap<String, dynamic> data1 = jsonDecode(resource.body)[list[h]];
      List list1 = data1.keys.toList();
      prod_id.add(list[h]);


      double lati=data1["Latitude"];
      owner_phone.add(data1["Owner_Number"].toString());
      owner_name.add(data1["Shop_Name"]);

      double longi=data1["Longitude"];

      LatLng l1=new LatLng(a,b);
      LatLng l2=new LatLng(lati,longi);

      Dio dio = new Dio();
      final response_distance=await http.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins="+l1.latitude.toString()+","+l1.longitude.toString()+
          "&destinations="+l2.latitude.toString()+","+l2.longitude.toString()+"&key=AIzaSyCcH5Qy8dTYdMNvQ8ufSzW9wpHY2qGhFK4");
      print("Received Data is :");
      LinkedHashMap<String, dynamic> data_distance = jsonDecode(response_distance.body);
//      List list_distance = data_distance.keys.toList();
////      print(list_distance);
//      LinkedHashMap<String, dynamic> data_distance1 = jsonDecode(response_distance.body)["rows"][0];
//      List list_distance1 = data_distance1.keys.toList();
////      print(list_distance1);
//      List< dynamic> data_distance2 = jsonDecode(response_distance.body)["rows"][0]["elements"];
////      List list_distance2 = data_distance2.keys.toList();
////      print(data_distance2);
//      LinkedHashMap<String, dynamic> data_distance3 = jsonDecode(response_distance.body)["rows"][0]["elements"][0];
//      List list_distance3 = data_distance3.keys.toList();
////      print(list_distance3);
//      LinkedHashMap<String, dynamic> data_distance4 = jsonDecode(response_distance.body)["rows"][0]["elements"][0]["distance"];
//      List list_distance4 = data_distance4.keys.toList();
////      print(list_distance4);
      String data_distance5 = jsonDecode(response_distance.body)["rows"][0]["elements"][0]["distance"]["text"];

      //print(data_distance5);
      distance.add(data_distance5);
//      print(data_distance2.values);
      //double distanceInMeters = await Geolocator().distanceBetween(a.toDouble(),b.toDouble(),lati.toDouble(),longi.toDouble());
      //print(distanceInMeters.toString());
      /*final Distance distance = new Distance();
      // km = 423
      final int km = distance.as(LengthUnit.Kilometer,
          new LatLng(a,b),new LatLng(lati,longi));
      print("Distance is :");
      print(km.toString());*/




      // meter = 422591.551
      /* final int meter = distance(
          new LatLng(52.518611,13.408056),
          new LatLng(51.519475,7.46694444)
      );*/
//
//        LinkedHashMap<String, dynamic> data3 = jsonDecode(resource.body)[list[h]]["Products"];
//        List list3 = data3.keys.toList();
//        int j = 0;
//        while (j < list3.length) {
//          LinkedHashMap<String, dynamic> data4 = jsonDecode(
//              resource.body)[list[h]]["Products"][list3[j]];
//          List list4 = data4.keys.toList();
//          print("City: " + data4[list4[0]].toString());
//          print("Cat: " + data4[list4[1]]);
//          print("Cat: " + data4[list4[2]]);
//          j++;
//        }

      h++;
    }

//  for (i in list1)
//  print(data[i]);
//    for(Map i in data){
//      print(i);}

//  var rest = data['Cuttack'];
//
//  print(rest);

    //for (a in data1["Cuttack"])
    //print(a);

    //list = rest.map<Article>((json) => Article.fromJson(json)).toList();
  }
print(prod_id);
  for(int i=0;i<distance.length;i++)
    {
      fdistance.add(distance[i]);
    }

  distance.sort();
  for(int i=0;i<distance.length;i++)
    {
      int x=fdistance.indexOf(distance[i]);
      fowner_name.add(owner_name[x]);
      fowner_phone.add(owner_phone[x]);
    }






  return list;
}

Future<String>_getAddressFromLatLng() async {
  try {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    curlat = _currentPosition.latitude.toString();
    curlon = _currentPosition.longitude.toString();

    Placemark place = p[0];
    //print("in this page");
    _currentAddress="${place.locality}";
    //print(place.locality);

    /*setState(() {
        _currentAddress = "${place.locality}";
        print(place.locality);
      });*/
    badd = _currentAddress;
    // print("Current location is :"+badd);
  } catch (e) {
    print(e);
  }

  var x=badd;
  // print("location is : "+x);
  return x;
}