  import 'dart:typed_data';

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_database/firebase_database.dart';
  import 'package:firebase_storage/firebase_storage.dart';
  import 'package:flutter/material.dart';
import 'package:project_duckhawk/shared/loading.dart';

  import '../main.dart';
  import 'cart.dart';
 // String prod_id;
  class item_info extends StatefulWidget {
    String product_id;
    item_info(
      this.product_id,);


    @override
    _item_infoState createState() => _item_infoState();
  }
  String p='pro4.jpg';
  String seller,imgurl,quantity,price="loading",name="Loading",description;
  DatabaseReference ref;

  class _item_infoState extends State<item_info> {
    //var _firebaseRef = FirebaseDatabase().reference().child('Products').child('Electronics');
    final FirebaseStorage storage = FirebaseStorage(
        app: Firestore.instance.app,
        storageBucket: 'gs://duckhawk-1699a.appspot.com');

    Uint8List imageBytes;
    String errorMsg;

    image() {
      storage.ref().child(p).getData(10000000).then((data) =>
          setState(() {
            imageBytes = data;
          })
      ).catchError((e) =>
          setState(() {
            errorMsg = e.error;
          })
      );
    }
  void initState(){
      DatabaseReference reference=FirebaseDatabase.instance.reference();
      reference.child('Products').child('Electronics').child(widget.product_id).once().then((DataSnapshot snap){
        var keys=snap.value.keys;
        print("The keys are :"+keys.toString());
        var data=snap.value;
        print("The data is :"+data.toString());
        //print(data.toString().split(',')[1]);
        seller=data.toString().split(',')[0];
        imgurl=data.toString().split(',')[1];
        quantity=data.toString().split(',')[2];
        price=data.toString().split(',')[3];
        name=data.toString().split(',')[4];
        description=data.toString().split(',')[5];
        print(seller+"\n"+imgurl+"\n"+quantity+"\n"+price+"\n"+name+"\n"+description);
        imgurl=imgurl.split(': ')[1];
        quantity=quantity.split(': ')[1];
        print("Quantity");
        print(quantity);


      });
  }
    @override
    Widget build(BuildContext context) {
      /*getData().then((val){
        print('Value is');
        print(val.price);
      });*/
      image();
      var img = imageBytes != null ? Image.memory(
        imageBytes,
        fit: BoxFit.cover,
      ) : Text(errorMsg != null ? errorMsg : "Loading...");

      return new Scaffold(
          appBar: new AppBar(
            title: new Text(name.split(': ')[1]),
          ),
        body:
        ListView(
          children: <Widget>[
            new Container(
              height: 300.0,
              child: GridTile(
                child: Container(
                  color: Colors.white,
                  child: Image.network(imgurl),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: new Container(
                    child: new Text(name.split(': ')[1]+"\n"+price.split(': ')[1]),
                  ),
                ),

                /*Expanded(
                  child: Row(
                    children: <Widget>[
                      DropdownButton<List>(

                      ),
                    ],
                  ),

                  child:MaterialButton(onPressed: (){},
                    color:Colors.white,
                    textColor: Colors.grey,
                    elevation:0.2,
                    child:Row(
                      children: <Widget>[
                        Expanded(
                            child: new Text("Quantity"),

                        ),
                        /*Expanded(
                            //child: new Icon(Icons.arrow_drop_down)
                        ),*/

                      ],
                    ),
                  ),
                ),*/


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
                    child:new Text("Buy Now"),
                  ),
                ),
                new IconButton(icon:Icon(Icons.add_shopping_cart),onPressed: (){}),
                new IconButton(icon:Icon(Icons.favorite),onPressed: (){}),
              ],
            ),
            Divider(),
            new ListTile(
              title:new Text("Product Details"),
              subtitle: new Text(description.split(': ')[1]),
              //subtitle: new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            )
          ],

        ),

  );

        /*body: ListView(
          children: <Widget>[
            new Container(
              height: 300.0,
              child: GridTile(
                child: Container(
                  color: Colors.white,
                  child: img,
                ),
                footer: new Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: new Text("Abc",
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                    title:new Row(
                      children: <Widget>[
                        Expanded(
                          child:new Text("2000"),
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
                    child:new Text("Buy Now"),
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

        ),*/
    }

    Future<void> addtocart() async {
      DocumentReference ref,ref1;
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final Firestore _firestore = Firestore.instance;
      FirebaseUser user = await _auth.currentUser();
      ref = _firestore.collection('users').document(user.uid);
     // print("hi");
      ref1=ref.collection('cart').document();
      //print(ref.documentID);

      ref.collection('cart').document(widget.product_id).setData({
        'ProductId':widget.product_id,
        'category':'electronics'
      });
      /*

      Firestore.instance.collection('/users').document().collection('/Carts').add({
        'prod_pic':widget.prod_pic,
        'prod_name':widget.prod_name,
        'prod_price':widget.prod_price


      });*/
    }

    getData() async{/*
      DatabaseReference re;
     // re.child('Products\Electronics\-LxGRP0DOWjWX1m0gVq').once().then((DataSnapshot data){
        //print(data.value);
        //print(data.key);
      }
      );
      return re;*/
    }
  }
