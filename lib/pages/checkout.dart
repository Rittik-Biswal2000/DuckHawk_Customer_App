import 'package:flutter/material.dart';
class checkout extends StatefulWidget {
  @override
  _checkoutState createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,

        backgroundColor: Color(0xff104670), //CHECK COLOR CODE
        title: Text("Shopping Cart"),

        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,color: Colors.white,
              ),
              onPressed: (){
              }),

        ],
      ),
    );
  }
}
