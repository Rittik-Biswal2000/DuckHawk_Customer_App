
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*
FirebaseUser user;
class cart1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title:'Cart',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyCart(title: 'Cart'),
    );
  }
}
class MyCart extends StatefulWidget {
  MyCart({Key key,this.title}):super(key: key);
  final String title;
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body:ListPage(),
    );
  }
}
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async{
    user=await FirebaseAuth.instance.currentUser();
    var firestore=Firestore.instance;
    print("user id:");
    print(user.uid);
    QuerySnapshot qn=await firestore.collection('users').document(user.uid).collection('cart').getDocuments();
    return qn.documents.toString();
  }
  @override
  Widget build(BuildContext context) {
    getPosts();
    return Container(
      height: 0.0,
      width: 0.0,


      child: FutureBuilder(
        future: getPosts(),
          builder:(_,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: Text("Loading"),
          );
        }else{
          ListView.builder(
            itemCount: snapshot.data.length,
              itemBuilder: (_,index){
              print("cart1 page");
              print(snapshot.data[index].data["ProductId"]);
            return ListTile(
              title:Text(snapshot.data[index].data["ProductId"]),
            );
          });

        }
      }),
    );

  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Posts.dart';
FirebaseUser user;
List l=[];
getuser() async{
  user=await FirebaseAuth.instance.currentUser();
  print(user.uid);
  Firestore.instance.collection('users').document(user.uid)
      .collection('cart').getDocuments()
      .then((snapshot) {
    snapshot.documents.forEach((f) => l.add('${f.data}'));
    print(l);
  });

  /* return Firestore.instance
      .collection('users')
      .document(user.uid).collection('cart')
      .getDocuments();*/

}/*
class cart1 extends StatelessWidget {
  List<Posts> postslist=[];
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

// TODO: implement build
    return new Scaffold(
      body: new Container(
        child: new FutureBuilder(
            future:getuser(), /*Firestore.instance
                .collection('users')
                .document('Y5odhsqgYeUKE98KtxdYis4vp4N2').collection('cart')
                .getDocuments(),*/
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return new Column(
                    children: <Widget>[
                      new Expanded(
                        child: new ListView(
                          children: snapshot.data.documents
                              .map<Widget>((DocumentSnapshot document) {
                            return new ListTile(
                              title: new Text(document['ProductId']),
                              subtitle: new Text(document['category']),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                }
              }else {
                return new CircularProgressIndicator();
              }
            }),),
    );
  }
}*/
class cart1 extends StatefulWidget {
  @override
  _cart1State createState() => _cart1State();
}

class _cart1State extends State<cart1> {
  List<Posts> postsList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getdoc();
  }
  getdoc()async{
    user=await FirebaseAuth.instance.currentUser();
    print(user.uid);
    Firestore.instance.collection('users').document(user.uid)
        .collection('cart').getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((f) => l.add('${f.data}'));
      for(int j=0;j<l.length;j++){
        DatabaseReference postsRef=FirebaseDatabase.instance.reference().child('Products').child('Electronics');
        postsRef.
      once().then((DataSnapshot snap)
        {
          var KEYS=snap.value.keys;
          var DATA=snap.value;
          postsList.clear();
          for(var individualKey in KEYS){
            Posts posts=new Posts
              (
              DATA[individualKey]['name'],
              DATA[individualKey]['price'],
              DATA[individualKey]['quantity'],

            );
            postsList.add(posts);
          }
          setState(() {
            print('length: $postsList.length');
          });

        });
      }
  });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cart1"),
      ),
      body:new Container(
        child: postsList.length==0?new Text("No items in cart"):new ListView.builder(
          itemCount: postsList.length,
            itemBuilder:(_,index){
            return PostsUI(postsList[index].name,postsList[index].quantity,postsList[index].price);
            }
        ),

      ),
    );
  }
  Widget PostsUI(String name,String quantity,String price)
  {
    return new Card(
      elevation:10.0,
      margin:EdgeInsets.all(15.0),
      child:new Container(
        padding: new EdgeInsets.all(14.0),
        child:new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           new Row(
             children: <Widget>[
               new Text(
                 name,

               ),
               new Text(
                 quantity,

               ),
               new Text(
                 price,

               ),
             ],
           )
          ],
        ),
      )
    );
  }
}
