import 'package:flutter/material.dart';
//my imports
import 'package:project_duckhawk/components/cart_products.dart';
import 'package:project_duckhawk/pages/checkout.dart';

class cart extends StatefulWidget {
  final c_p_pic;
  final c_p_name;
  final c_p_price;


  cart(this.c_p_pic, this.c_p_name, this.c_p_price);


  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {


  createAlertDialog(BuildContext context)
    {
      TextEditingController customController = TextEditingController();
      return showDialog(context: context,builder: (context){
        return AlertDialog(
          title: Text("Items available for checkout"),
          content: Image.asset("images/download (4).png"),
          actions: <Widget>[
            MaterialButton(
              elevation:5.0,
              child: Text('Submit'),
              onPressed: (){},
            )
          ],
        );
      });
  }
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
              onPressed: (){}),

        ],
      ),
      body:new Cart_Products(widget.c_p_pic,widget.c_p_name,widget.c_p_price),
      bottomNavigationBar: new Container(
        color:Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child:ListTile(
              title: new Text("Total Amount:"),
              subtitle: new Text("₹2000"),
            )),
            Expanded(
              child: new FlatButton(onPressed: (){
                createAlertDialog(context);
              },
              child:Text("Check Out",style:TextStyle(color: Colors.white)),
              color: Colors.redAccent),
            )
          ],
        ),
      ),
    );
  }
}
