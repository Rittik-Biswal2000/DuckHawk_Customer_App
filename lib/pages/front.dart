import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'note.dart';
class front extends StatefulWidget {
  @override
  _frontState createState() => _frontState();
}

String curlat,curlon;
List seller=[];
List imgurl=[];
List quantity=[];
List price=[];
List name=[];
List description=[];
List l=[];
List prod_id=[];
List prod_cat=[];
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

class _frontState extends State<front> {
  List<Note>_notes=List<Note>();
  Future fetchNotes()async{
    var x=await _getCurrentLocation();
    var url='https://duckhawk-1699a.firebaseio.com/Seller/'+x+'.json';
    print(url);
    var response=await http.get(url);
    var notes=List<Note>();
    if(response.statusCode==200)
      {
        var notesJson=json.decode(response.body);
        for(var noteJson in notesJson )
          {
            notes.add(Note.fromJson(noteJson));
            print(noteJson);
          }
        print("notes are :");
        print(notesJson);

      }
  }
  @override
  void initState() {

      fetchNotes().then((value){
        setState(() {
          _notes.addAll(value);
        });
      });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hi"),
      ),
      body:
        ListView.builder(

            itemBuilder: (context,index){
              print("hi");
              print(_notes[index].Owner_Number);
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_notes[index].Shop_Name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    Text(_notes[index].Owner_Number),
                  ],
                ),
              );
            },
          itemCount: _notes.length,
            )
    );
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
