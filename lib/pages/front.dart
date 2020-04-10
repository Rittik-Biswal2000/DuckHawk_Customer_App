import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/src/welcomPage.dart';

class front extends StatefulWidget {

  @override
  _frontState createState() => _frontState();
}

FirebaseUser user;
String curlat,curlon;

String badd="Loading";
//List se=[];
//List se_name=[];
//List se_phone=[];
var n;
int j;
ProgressDialog pr;
final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

Position _currentPosition;
String _currentAddress ;
String name="Login/SignUp";
FirebaseUser mCurrentUser;
FirebaseAuth _auth;


int d=0;
String add="hi";
class _frontState extends State<front> {
  @override
  void initState() {
    // TODO: implement initState

    getcurrentlocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("in front page");
    print(se);
    print(se_name);
    print(se_phone);
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    getseller();
    return Scaffold(
        body: Text("hello")
    );
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
     // print(badd);
    } catch (e) {
      print(e);
    }
  }

  getseller() {
    int i;


   // print("seller");
   // print("badd" + _currentAddress);
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    reference.child('Seller').child(badd).once().then((DataSnapshot snapshot) {
      //print('Key : ${snapshot.key}');
      // print('Data : ${snapshot.value}');
      var l = snapshot.value.toString().split(': ')[0].length;
      //print('Data : ${snapshot.value.toString().split(': ')[0]}');
      //print('Data : ${snapshot.value.toString().split(': ')[0].substring(1,l)}');
      se.add(snapshot.value.toString().split(': ')[0].substring(1, l));
      //print('Data : ${snapshot.value.toString().split('}},')[1]}');
      //print('Data : ${snapshot.value.toString().split('}},')[1].split(': ')[0]}');
      n = snapshot.value
          .toString()
          .split('}},')
          .length;
      DatabaseReference ref1 = FirebaseDatabase.instance.reference();
      for (i = 1; i < n; i++) {
        se.add(snapshot.value.toString().split('}}, ')[i].split(':')[0]);
        ref1.child('ApplicationForSeller').child(se[i]).once().then((
            DataSnapshot snapshot) {
          //print('Key : ${snapshot.key}');
          print('Data : ${snapshot.value}');
          se_name.add(snapshot.value.toString().split(',')[3]);
          se_phone.add(snapshot.value.toString().split(',')[10]);
        });
      }
      print("bye");
      print(se_name);
      //print("hi");
      //print("se");
      //print(se_name);

      /* DatabaseReference ref1=FirebaseDatabase.instance.reference();
      for( j=0;j<s.length;j++){
        ref1.child('ApplicationForSeller').child(se[j]).once().then((DataSnapshot snapshot){
          //print('Key : ${snapshot.key}');
          print('Data : ${snapshot.value}');
          se_name.add(snapshot.value.toString().split(',')[3]);
          se_phone.add(snapshot.value.toString().split(',')[10]);



        });
      }*/

      //print("se is");
     // print(se);
    });


    //Navigator.push(context, MaterialPageRoute(builder: (context) => new Seller(),));


  }
}

