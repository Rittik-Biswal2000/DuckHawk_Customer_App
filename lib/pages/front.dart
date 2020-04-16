import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/src/welcomPage.dart';

import 'Posts.dart';
/*
class front extends StatefulWidget {
  @override
  _frontState createState() => _frontState();
}

class _frontState extends State<front> {
  List<Posts> postsList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference postsRef=FirebaseDatabase.instance.reference().child("Seller").child("Cuttack");
    postsRef.once().then((DataSnapshot snap)
    {
      var keys=snap.value.keys;
      var data=snap.value;
      print("keys are :");
      print(keys);
      postsList.clear();
      for(var individualkey in keys)
      {
        Posts posts=new Posts
          (
          data[individualkey]['Owner_Number'],
          data[individualkey]['Shop_Name'],

        );



        postsList.add(posts);

      }

      setState(() {
        print('Length :$postsList.length');
      });

    });

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:new Text("home"),
      ),
      body:
        new Container(
          child: postsList.length==0?new Text("No posts available"):new ListView.builder(
            itemCount: postsList.length,
              itemBuilder: (_,index)
              {
                print("owner number");
                print(postsList[index].Owner_Number);
                return PostsUI(postsList[index].Owner_Number,postsList[index].Shop_Name);
              }
          ),
        ),
    );
  }
  Widget PostsUI(String cat,String prodid)
  {
    return new Card(
        elevation: 10.0,
        margin: EdgeInsets.all(15.0),
        child:new Container(
          padding: new EdgeInsets.all(14.0),
          child:new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                cat,
              )
            ],
          ),
        )
    );
  }
}
*/

class front extends StatefulWidget {

  @override
  _frontState createState() => _frontState();
}
FirebaseUser user;
String curlat,curlon;

String badd="Loading";
List se=[];
var se_details=new List<String>();
List se_name=[];
List se_phone=[];
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
    getc();
    getseller();





    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var futureBuilder=new FutureBuilder(
      future: getseller(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return new Text('Press button to start');
              break;
            case ConnectionState.waiting:
              return new Text('Awaiting result');
              // TODO: Handle this case.
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              // TODO: Handle this case.
              break;
            default:
              if(snapshot.hasError)
                return new Text('Error :${snapshot.error}');
              else
                return createListview(context,snapshot);
          }
        },);
    //getseller();
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Cart"),
          backgroundColor: Color(0xff104670),
        ),
      body:
       futureBuilder,
      /*ListView.builder(
        itemCount: n,
          itemBuilder: (context,index){
          return Card(
            child: ListTile(
              onTap: (){},
              title: Text(se_details[index]),
            ),
          );
          })*/
    );
  }


 getc() {
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
      print("is:");
      // print(badd);
    } catch (e) {
      print(e);
    }
  }
   Future<List<String>> getseller() async{

      int i;



      // print("seller");
      // print("badd" + _currentAddress);
      DatabaseReference reference = FirebaseDatabase.instance.reference();
      reference.child('Seller').child(badd).once().then((
          DataSnapshot snapshot) {
        //print('Key : ${snapshot.key}');
        print('Data : ${snapshot.value}');
        var l = snapshot.value.toString().split(': ')[0].length;
        n = snapshot.value
            .toString()
            .split('}},')
            .length;
        se_details.add(snapshot.value.toString().split(': {')[1]);
        //print('${snapshot.value.toString().split(': {')[1]}');
        //print('${snapshot.value.toString().split('}}, ')[1].split(': {')[1]}');
        for (j = 1; j < n; j++) {
          se_details.add(
              snapshot.value.toString().split('}}, ')[j].split(': {')[1]);
        }

        //print('Data : ${snapshot.value.toString().split(': ')[0].substring(1,l)}');

        se.add(snapshot.value.toString().split(': ')[0].substring(1, l));
        //print('Data : ${snapshot.value.toString().split('}},')[1]}');
        //print('Data : ${snapshot.value.toString().split('}},')[1].split(': ')[0]}');

        for (j = 1; j < n; j++) {
          se.add(snapshot.value.toString().split('}}, ')[j].split(': ')[0]);
        }
        print("hi");

        for (j = 0; j < n; j++) {
          print(se_details[j]);
        }

        //print("bye");
        //print(se_name);
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
      //await new Future.delayed(new Duration(seconds:5));
      print("bye");
      print(se_details);
     if(se_details==null)
       {
         return se;
       }
     else
       {
         return se_details;
       }



    }

  Widget createListview(BuildContext context, AsyncSnapshot snapshot) {
    return new ListView.builder(
      itemCount: n,
        itemBuilder: (BuildContext context,int index){
          return new Column(
            children: <Widget>[
              new ListTile(
                title:new Text(se_details[index]),
              ),
              new Divider(height: 2.0,),
            ],
          );
        });
  }

}

