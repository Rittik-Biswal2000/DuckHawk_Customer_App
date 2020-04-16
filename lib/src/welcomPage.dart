import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/category.dart';
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
ProgressDialog pr;
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
   // getseller();

    getuser();
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
    await getproducts();
    pr.hide();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(null)),
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

getproducts() async {
  owner_phone.clear();
  owner_name.clear();
  var o=await _getCurrentLocation();
  print("badd is : "+'${o}');
 DatabaseReference ref=FirebaseDatabase.instance.reference().child('Seller').child(o);
  await ref.once().then((DataSnapshot s){
    print(s.value);
    var data=s.value;
    print(s.value.toString().split('}}, ').length);
    length=s.value.toString().split('}}, ').length;
    var ind=data.toString().split('}}, ');

    for(int i=0;i<length;i++)
      {
        owner_name.add(ind[i].split(': {')[1].split(',')[1].split(': ')[1]);
        owner_phone.add(ind[i].split(': {')[1].split(',')[0].split(': ')[1]);
      }
   // print(owner_name);
   // print(owner_phone);
   // print(owner[1].split(',')[1].split(': ')[1]);
    //print(owner[1]);
  });
  print("bye");






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
