import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/pages/cart2.dart';
import 'package:project_duckhawk/pages/categories.dart';
import 'package:project_duckhawk/pages/location.dart';
import 'package:project_duckhawk/src/welcomPage.dart';
import 'package:project_duckhawk/main.dart';
import 'package:splashscreen/splashscreen.dart';
/*


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {


      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              )
            ],
          );
        },
      ) ?? false;
    }
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(

        title: 'Duckhawk',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
            body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: categories(),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}
var a,b,bl;
final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

Position _currentPosition;
String _currentAddress ;
_getcurrentloc() async {
  var isGpsEnabled = await Geolocator().isLocationServiceEnabled();
  print("current state of gps");
  print(isGpsEnabled);
  if (isGpsEnabled == false) {

    pr.hide();




  } else {
    var p;
    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;

    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      _currentPosition = position;
      a = position.latitude;
      b = position.longitude;
      p = await _getAddressFromLatLng();
      /*setState(() {
    });*/
      //
    }).catchError((e) {
      print(e);
    });

    //print("p is :"+'${p}');
    return p;
  }
}

_getAddressFromLatLng() async {
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
    bl = _currentAddress;
    // print("Current location is :"+badd);
  } catch (e) {
    print(e);
  }

  var x=bl;
  var xl=x;
  // print("location is : "+x);
  return x;
}
ProgressDialog pr;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    _getcurrentloc();

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
    return new SplashScreen(

      seconds: 3,
      navigateAfterSeconds: new categories("Select location"),
      title: new Text('Duckhawk',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          color:Colors.white
        ),
      ),
      //: new Image.network('https://flutter.io/images/catalog-widget-placeholder.png'),
      //backgroundGradient: new LinearGradient(colors: [Colors.cyan, Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
      backgroundColor: Colors.deepPurple,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red,

    );
  }
}