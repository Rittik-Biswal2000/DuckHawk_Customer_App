import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    )
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(104670), //CHECK COLOR CODE
        title: Text('Your Location \nBURLA'),
      ),
      endDrawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: Text('Ekanta'), accountEmail: null,currentAccountPicture: GestureDetector(
              child: new CircleAvatar(),),
            ),
          ],
        ),
      ),
    );
  }
}
