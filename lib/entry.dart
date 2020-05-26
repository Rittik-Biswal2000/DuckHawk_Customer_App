import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
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

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(

      seconds: 5,
      navigateAfterSeconds: new categories(),
      title: new Text('Duckhawk',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
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