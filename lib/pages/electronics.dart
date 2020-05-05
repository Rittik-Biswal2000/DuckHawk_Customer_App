import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_duckhawk/pages/cart.dart';

import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/main.dart';

class e extends StatefulWidget {
  String s;

  e(
      this.s);
  @override
  _eState createState() => _eState();
}
String a,b,c,d,f,g;
class _eState extends State<e> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Color(0xff104670),
          automaticallyImplyLeading: false,
          title: Text("My Products")
        //leading:new Text("hi"),


      ),
      body: Container(
        child: new ListView.builder(
          itemCount: len1,
          itemBuilder: (BuildContext context,int index){
            //qu=quantity[index];
            //total_price+=double.parse(prod_price[index])*double.parse(units[index]);
            //return new Text(item_name[index]);
            return new Card(
              child: SingleChildScrollView(
                  child:InkWell(
                    child: ListTile(

                      leading:
                        new Image.network(imgurl1[index],width:100.0,height:400.0),
                      /*InkWell(
                          onTap: (){
                            print(prod_id[index]);
                            print(imgurl1[index]);
                            print(name1[index]);
                            print(price1[index]);
                            print(description1[index]);
                            print(quantity1[index]);
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => item_info(prod_id[index],imgurl1[index],name1[index],price1[index],description1[index],quantity1[index])));

                          },
                          child:
                          new Image.network(imgurl1[index],width:100.0,height:400.0)
                      ),*/
                      title:new Text(name1[index]),
                      subtitle: new Column(
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.all(8.0),

                                child:new Text("Price : ₹"+price1[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                            ),
                            /*alignment: Alignment.topLeft,
                          child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                          ),
                          new Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.all(8.0),



                                child:new Text("Quantity : "+quantity1[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                            ),
                            //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                          ),
                          /*new Row(
                            children: <Widget>[
                              new FlatButton(onPressed: (){
                                //createAlertDialog(context, name.split(': ')[1], imgurl, price.split(': ')[1]);





                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => new item_info(prod_id2[index],imgurl1[index],name1[index],price1[index],description1[index],quantity1[index])));

                                // createAlertDialog(context,item_name[index],imageurl[index],prod_price[index],item_units[index],u[index].data["ProductId"]);
                              },
                                  child:Text("Update")
                              ),
                              new FlatButton(
                                  onPressed: (){

                                    //l[index].toString().split(': ')[1].split(',')[0]
                                    // firestore.collection('users').document(user.uid).collection('cart').document(u[index].data["ProductId"]).delete();


                                    //refreshList();
                                    //Navigator.pop(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));

                                  }, child: Text("Remove")),

                            ],
                          ),*/

                        ],
                      ),

                    ),
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => new item_info(widget.s,prod_id2[index],imgurl1[index],name1[index],price1[index],description1[index],quantity1[index])));
                      //Navigator.pop(context);
                      /*print(prod_id[index]);
                      print(imgurl1[index]);
                      print(name1[index]);
                      print(price1[index]);
                      print(description1[index]);
                      print(quantity1[index]);*/


                    },
                  )
              ),
            );
          },



        ),

      ),
    );
  }
}


