import 'package:flutter/material.dart';
import 'package:project_duckhawk/main.dart';
class myorders extends StatefulWidget {
  @override
  _myordersState createState() => _myordersState();
}

class _myordersState extends State<myorders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My Orders"),
      ),
      body:Container(
    child:new ListView.builder(
    itemCount: ucat.length,
        itemBuilder: (BuildContext context,int index){
          //currrentseller=sellerlist[index];
          return new Card(
              child:SingleChildScrollView(
                  child:InkWell(
                    onTap: ()async{/*
                      pr.show();
                      await getproductdetails(prod_id[index]);
                      pr.hide();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => e(sellerlist[index])),
                      );
                      // Navigator.pop(context);


                    */},
                    child: ListTile(
                      title: new Text(ucat[index].toString()),
                      subtitle: new Column(
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: new Text("Price - "+uprice[index].toString()),
                            ),
                          ),
                          new Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: new Text("Quantity - "+uquantity[index].toString()),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              )
          );
        }),
    ),
    );
  }
}
