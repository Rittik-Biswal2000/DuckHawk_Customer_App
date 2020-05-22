import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_duckhawk/pages/cart2.dart';
import 'package:project_duckhawk/pages/location.dart';
import 'package:project_duckhawk/src/welcomPage.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/src/welcomPage.dart';


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

        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
            body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: WelcomePage(),
      ),
    );
  }
}