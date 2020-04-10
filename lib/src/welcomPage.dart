import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/front.dart';
import 'package:project_duckhawk/src/loginPage.dart';
import 'package:project_duckhawk/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_duckhawk/pages/login_page.dart';
import 'package:project_duckhawk/src/signup.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}
FirebaseUser user;
String curlat,curlon;

String badd="Loading";
List se=[];
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

/*  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Quick login with Touch ID',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.fingerprint, size: 90, color: Colors.white),
            SizedBox(
              height: 20,
            ),
            Text(
              'Touch ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ));
  }*/

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
    getseller();

    getuser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => front()),
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
      print(badd);
    } catch (e) {
      print(e);
    }
  }
}
getseller() {
  int i;


  print("seller");
  print("badd" + _currentAddress);
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
    print("hi");
    print("se");
    print(se_name);

    /* DatabaseReference ref1=FirebaseDatabase.instance.reference();
      for( j=0;j<s.length;j++){
        ref1.child('ApplicationForSeller').child(se[j]).once().then((DataSnapshot snapshot){
          //print('Key : ${snapshot.key}');
          print('Data : ${snapshot.value}');
          se_name.add(snapshot.value.toString().split(',')[3]);
          se_phone.add(snapshot.value.toString().split(',')[10]);



        });
      }*/

    print("se is");
    print(se);
  });


  //Navigator.push(context, MaterialPageRoute(builder: (context) => new Seller(),));


}