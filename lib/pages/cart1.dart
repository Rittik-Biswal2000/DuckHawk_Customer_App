import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_duckhawk/pages/item_info.dart';
/*void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
      //home:LoginPage()));


      home:cart1()));
}*/
class cart1 extends StatefulWidget {
  @override
  _cart1State createState() => _cart1State();
}

class _cart1State extends State<cart1> {
  List n=[];
  List p=[];
  List im=[];
  getd() async{
    n.clear();
    p.clear();
    im.clear();
    DatabaseReference reference=FirebaseDatabase.instance.reference();
    reference.child('Products').child('Bhubaneswar').child('Electronics').once().then((DataSnapshot snap){
      var keys=snap.key;
      var data=snap.value;
      //print(data.toString());
      //print( data);
      //print(data.toString().split(': {')[1].split(',')[1].split(': ')[1]);
      var l=data.toString().split(': {')[0].length;
      //print(data.toString().split(': {')[0].substring(1,l));
      im.add(data.toString().split(': {')[1].split(',')[1].split(': ')[1]);
      p.add(data.toString().split(': {')[0].substring(1,l));
      n=data.toString().split('},');
      for(int i=1;i<n.length;i++)
      {
        p.add(n[i].toString().split(': ').toString().split(', {')[0].split('[ ')[1]);
        im.add(n[i].toString().split('{').toString().split(',')[2].split(': ')[1]);

      }

      for(int i=0;i<p.length;i++)
      {
        print(im[i]);
      }


    });




  }
  @override
  void initState() {
    // TODO: implement initState
    getd();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        // title: title,
        home:Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff104670),
              title: Text("electronics"),
            ),
            body:GridView.count(
              crossAxisCount: 2,
              children: List.generate(p.length, (index) {
                print("hi");
                print(p[index]);
                print(im[index]);
                return Center(
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      child: GridTile(
                        child:InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>new item_info(p[index])));
                              print("item_info");
                            },
                            child: Image.network(
                              im[index]
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
