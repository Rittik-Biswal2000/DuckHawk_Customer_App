import 'package:flutter/material.dart';
import 'package:project_duckhawk/pages/item_info.dart';
class cart2 extends StatefulWidget {
  @override
  _cart2State createState() => _cart2State();
}

class _cart2State extends State<cart2> {
  createAlertDialog2(BuildContext context,String name,String cat,String pic,String price,String quantity,String id,String seller)
  {

    //total=double.parse(price)*double.parse(quantity);
    print("in 1st dialog box");
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AlertDialog(

          title: Text("Items available for checkout"),
          content: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Text(name),
                    ),
                  )
                  //new Text(cart_prod_name,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold),)
                ],

              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(pic,width:100.0,height:200.0),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("Quantity: "+quantity),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("Price: ₹"+price,textAlign: TextAlign.end,),
                ],
              ),
              new Row(


                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text("Total : ₹"+price.toString(),textAlign: TextAlign.end,),
                  ),

                ],
              )
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              elevation:5.0,
              child: Text('Submit'),
              onPressed: (){
                Navigator.of(context).pop();
                //createAlertDialog1(context,name,cat,pic,price,quantity,id,seller);

              },
            )
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Carts'),
      ),
      body:Container(
    child:  ListView.builder(
          itemCount: clength,
          itemBuilder: (context,index){
            return new Card(
              child: SingleChildScrollView(
                child:ListTile(

                  leading:InkWell(
                      onTap: (){
                      },
                      child:
                      new Image.network(cimage[index],width:100.0,height:400.0)
                  ),
                  title:new Text(cname[index]),
                  subtitle: new Column(
                    children: <Widget>[
                      new Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.all(8.0),

                            child:new Text("Price : ₹"+cprice[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                        ),
                        /*alignment: Alignment.topLeft,
                        child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                      ),
                      new Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.all(8.0),

                            child:new Text("Quantity : "+cquantity[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                        ),
                        //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                      ),
                      new Row(
                        children: <Widget>[
                          new FlatButton(onPressed: (){
                            createAlertDialog2(context,cname[index],ccat[index],cimage[index],cprice[index],cquantity[index],cid[index],cseller[index]);
                          },
                              child:Text("Place Order")
                          ),
                          new FlatButton(
                              onPressed: (){
                                //l[index].toString().split(': ')[1].split(',')[0]
                                //firestore.collection('users').document(user.uid).collection('cart').document(u[index].data["ProductId"]).delete();


                                //refreshList();
                                //Navigator.pop(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));

                              }, child: Text("Delete")),

                        ],
                      ),
                    ],
                  ),

                ),

              ),

            );

          })
    ),
    );
  }
}
