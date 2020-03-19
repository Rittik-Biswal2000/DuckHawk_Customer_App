import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_duckhawk/pages/cart.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/shared/loading.dart';
class electronics extends StatefulWidget {
  @override
  _electronicsState createState() => _electronicsState();
}
List n;
int i;
void getproducts() {
  print("hello");
  DatabaseReference reference=FirebaseDatabase.instance.reference();
  reference.child('Products').child('Electronics').once().then((DataSnapshot snap){
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

class _electronicsState extends State<electronics> {
  @override
  void initState() {
    // TODO: implement initState
    //getproducts();
    super.initState();
  }
  /*
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: n.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              prod_id: n[index].toString().split(': ').toString().split(', {')[0].split('[ ')[1],
              prod_name: n[index].toString().split('{').toString().split(',')[5].split(': ')[1],
              prod_pricture: n[index].toString().split('{').toString().split(',')[2].split(': ')[1],
            ),
          );
        });
  }*/



  @override
  Widget build(BuildContext context) {
   final title='Electronics';
   return MaterialApp(
       debugShowCheckedModeBanner: false,

     title: title,
     home:Scaffold(
       appBar: AppBar(
         backgroundColor: Color(0xff104670),
         title: Text(title),
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
                         /*footer: Container(
                           height: 100.0,
                           color: Colors.white70,
                           child: ListTile(
                             leading: Text(
                               n[index].toString().split('{').toString().split(',')[5].split(': ')[1],
                               style: TextStyle(fontWeight: FontWeight.bold),
                             ),
                           ),
                         ),*/
                         child: Image.network(
                           n[index].toString().split('{').toString().split(',')[2].split(': ')[1],
                           //fit: BoxFit.cover,
                         )
                     ),
                      /* footer: Container(
                         height: 100.0,
                         color: Colors.white70,
                         child: ListTile(
                           leading: Text(
                             n[index].toString().split('{').toString().split(',')[5].split(': ')[1],
                             style: TextStyle(fontWeight: FontWeight.bold),
                           ),
                         ),
                       ),
                       child: Image.network(
                         n[index].toString().split('{').toString().split(',')[2].split(': ')[1],
                         //fit: BoxFit.cover,
                       )*/),

               ),
             ),

           );
         }),
       )
     )
   );

  }


}
/*
class Single_prod extends StatelessWidget {
  final prod_id;
  final prod_name;
  final prod_pricture;

  Single_prod({
    this.prod_id,
    this.prod_name,
    this.prod_pricture,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new item_info(prod_id)));
              },
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                    ),
                  ),
                  child: Image.network(
                    prod_pricture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}*/

