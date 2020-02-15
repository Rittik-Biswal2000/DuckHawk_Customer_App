import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final product_name;
  final product_picture;

  ProductDetails({
    this.product_name,
    this.product_picture});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(

          backgroundColor: Color(0xff104670), //CHECK COLOR CODE
          title: Text(widget.product_name),

          actions: <Widget>[
            new IconButton(
              icon: Icon(
                Icons.search,color: Colors.white,
              ),
              onPressed: (){}),
            new IconButton(
              icon: Icon(
                Icons.shopping_cart,color: Colors.white,
              ),
        onPressed: (){},)
          ],
      ),

      body: new ListView(
        children: <Widget>[
          new Container(
            height:300.0,
            child: GridTile(
              child: Container(
                color: Colors.white70,
                child: Image.asset(widget.product_picture),
              ),
            ),
          )
        ],
      ),
    );
  }
}
