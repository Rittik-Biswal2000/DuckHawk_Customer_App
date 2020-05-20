import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/cart2.dart';
import 'package:project_duckhawk/pages/item_info.dart';

import 'account1.dart';
class myorders extends StatefulWidget {
  @override
  _myordersState createState() => _myordersState();
}
ProgressDialog pr;
class _myordersState extends State<myorders> {

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xff104670),
        title: new Text("My Orders"),
      ),
      bottomNavigationBar: new Container(
        padding: EdgeInsets.all(0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                icon: new Icon(Icons.shop),
                onPressed: () async{
                  //pr.show();
                  //await getData(null);
                  //pr.hide();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage(null)));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.search),
                  onPressed: () async {

                  }),
            ),
            Expanded(
              flex: 1,
              child: IconButton (
                  icon: new Icon(Icons.account_box),
                  onPressed: () async{
                    pr.show();
                    await getuac();
                    pr.hide();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>new acc1()));
                  }),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: new Icon(Icons.shopping_cart),
                onPressed: () async {
                  pr.show();
                  await getcartData();
                  pr.hide();
                  print("Time taken");
                  stime=s.elapsedMilliseconds;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart2()));
                },),
            ),
            /*Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.share),
                  onPressed: () => _onClick('Button3')),
            ),*/
          ],
        ),
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
