import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/cart.dart';

class indivProduct extends StatefulWidget {
  final prod_name;
  final prod_pic;
  final prod_price;


  indivProduct(this.prod_name, this.prod_pic, this.prod_price);

  @override
  _indivProductState createState() => _indivProductState();
}

class _indivProductState extends State<indivProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: new AppBar(

    backgroundColor: Color(0xff104670), //CHECK COLOR CODE
    title: Text(widget.prod_name),

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

      body: ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
              child: GridTile(
                child: Container(
                  color: Colors.white,
                  child: Image.asset(widget.prod_pic),
                ),
                footer: new Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: new Text(widget.prod_name,
                    style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                    title:new Row(
                      children: <Widget>[
                        Expanded(
                          child:new Text("${widget.prod_price}"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child:MaterialButton(onPressed: (){},
                color:Colors.white,
                textColor: Colors.grey,
                  elevation:0.2,
                  child:Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Quantity")
                      ),
                      Expanded(
                          child: new Icon(Icons.arrow_drop_down)
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child:MaterialButton(
                  onPressed:()  {
                    addtocart();
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>new cart()));
                  },
                  color:Colors.redAccent,
                  textColor: Colors.white,
                  elevation: 0.2,
                    child:new Text(currentUser().toString()),
                ),
              ),
              new IconButton(icon:Icon(Icons.add_shopping_cart),onPressed: (){}),
              new IconButton(icon:Icon(Icons.favorite),onPressed: (){}),
            ],
          ),
          Divider(),
          new ListTile(
            title:new Text("Product Details"),
            subtitle: new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          )
        ],

      ),
    );
  }

  Future<void> addtocart() async {
    DocumentReference ref;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    ref = _firestore.collection('users').document(user.uid);
    print("hi");
    print(ref.documentID);
    ref.collection('cart').add({
      'prod_pic':widget.prod_pic,
      'prod_name':widget.prod_name,
      'prod_price':widget.prod_price
    });/*
    Firestore.instance.collection('/users').document().collection('/Carts').add({
      'prod_pic':widget.prod_pic,
      'prod_name':widget.prod_name,
      'prod_price':widget.prod_price


    });*/
  }
}
