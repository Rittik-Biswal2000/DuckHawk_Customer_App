import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_duckhawk/pages/cart.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/shared/loading.dart';
String cat;
class category extends StatefulWidget {
  final String c;

  category(this.c);


  @override
  _categoryState createState() => _categoryState();
}
List n;
int i;
void getproducts1() {
/*
  print("hello");
  print(cat);
  DatabaseReference reference=FirebaseDatabase.instance.reference();
  reference.child('Products').child(cat).once().then((DataSnapshot snap){
    var keys=snap.key;
    var data=snap.value;
    print("keys are :"+ keys.toString());
    n=data.toString().split('},');
    //data.toString().split('},').length;
    //print("Lenght of lenght");
    //print(n[0].toString().split('{'));
    //print(n[0].toString().split('{').toString().split(',')[2].split(': ')[1]);
    //String m=n[1].toString().split('{').toString();
    //print(m.split(',')[2].split(': ')[1]);
    //print(n[2]);
    print(n[1].toString().split(': ').toString().split(', {')[0].split('[ ')[1]);

    for(i=1;i<n.length;i++)
    {
      print(n[i].toString().split('{').toString().split(',')[5].split(': ')[1]);
    }
    /*
      seller=data.toString().split(',')[0];
      imgurl=data.toString().split(',')[1];
      quantity=data.toString().split(',')[2];
      price=data.toString().split(',')[3];
      name=data.toString().split(',')[4];
      description=data.toString().split(',')[5];
      imgurl=data.toString().split(',')[1];
      imgurl=imgurl.split(': ')[1];*/
    //print(imgurl);




  });*/
}

class _categoryState extends State<category> {

  @override
  void initState() {
    // TODO: implement initState
    //getproducts();
    super.initState();
    print("hello");
    print(cat);
    DatabaseReference reference=FirebaseDatabase.instance.reference();
    reference.child('Products').child('Bhubaneswar').child(widget.c).once().then((DataSnapshot snap){
      var keys=snap.key;
      var data=snap.value;
      print("keys are :"+ keys.toString());
      n=data.toString().split('},');
      //data.toString().split('},').length;
      //print("Lenght of lenght");
      //print(n[0].toString().split('{'));
      //print(n[0].toString().split('{').toString().split(',')[2].split(': ')[1]);
      //String m=n[1].toString().split('{').toString();
      //print(m.split(',')[2].split(': ')[1]);
      //print(n[2]);
      print(n[1].toString().split(': ').toString().split(', {')[0].split('[ ')[1]);

      for(i=1;i<n.length;i++)
      {
        print(n[i].toString().split('{').toString().split(',')[5].split(': ')[1]);
      }
      /*
      seller=data.toString().split(',')[0];
      imgurl=data.toString().split(',')[1];
      quantity=data.toString().split(',')[2];
      price=data.toString().split(',')[3];
      name=data.toString().split(',')[4];
      description=data.toString().split(',')[5];
      imgurl=data.toString().split(',')[1];
      imgurl=imgurl.split(': ')[1];*/
      //print(imgurl);




    });
  }

  @override
  Widget build(BuildContext context) {
    //final title='Electronics';
    return MaterialApp(
        debugShowCheckedModeBanner: false,

       // title: title,
        home:Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff104670),
              title: Text("${widget.c}"),
            ),
            body:GridView.count(
              crossAxisCount: 2,
              children: List.generate(n.length, (index) {
                return Center(
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      child: GridTile(
                        child:InkWell(
                            onTap: (){
                              Loading();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>new item_info(n[index].toString().split(': ').toString().split(', {')[0].split('[ ')[1])));
                              print("item_info");
                            },
                            child: Image.network(
                              n[index].toString().split('{').toString().split(',')[2].split(': ')[1],
                              //fit: BoxFit.cover,
                            )
                        ),
                       ),

                    ),
                  ),

                );
              }),
            )
        )
    );

  }


}
