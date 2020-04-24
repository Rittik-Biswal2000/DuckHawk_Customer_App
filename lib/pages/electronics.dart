import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_duckhawk/pages/cart.dart';
import 'package:project_duckhawk/pages/front.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/shared/loading.dart';
/*
class electronics extends StatefulWidget {
  @override
  _electronicsState createState() => _electronicsState();
}
List n=[];
List id=[];
int i;
void getproducts() {
  id.clear();
  //id.add(" ");

  int l;
  String d;
  print("hello");
  DatabaseReference reference=FirebaseDatabase.instance.reference();
  reference.child('Products').child('Bhubaneswar').child('Electronics').once().then((DataSnapshot snap){
    var keys=snap.key;
    var data=snap.value;
    print("keys are :"+ keys.toString());


     n=data.toString().split('},');
     print("0th node is ");
     print(n[0].split(': {')[0].toString());
     d=n[0].split(': {')[0].toString();
     l=n[0].split(': {')[0].toString().length;
     print(d.substring(1,l));
     print(n[0].toString().split('{ '));
     id.add(d.substring(1,l));
     print("Something");
    print(n[2].toString().split(': ').toString().split(', {')[0].split('[ ')[1]);
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
        (
            //n[index].toString().split(': ').toString().split(', {')[0].split('[ ')[1])
        //print(n[i].toString().split('{').toString().split(',')[5].split(': ')[1]);
       // id.add(n[i].toString().split(': ').toString().split(', {')[0].split('[ ')[1]);
      }
    print("id is ");
    print(id);
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
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>new item_info(
                             n[index].toString().split(': ').toString().split(', {')[0].split('[ ')[1])));
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
}



 */


String cat;
class electronics extends StatefulWidget {



  @override
  _electronicsState createState() => _electronicsState();
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

class _electronicsState extends State<electronics> {

  @override
  void initState() {
    // TODO: implement initState
    //getproducts();
    super.initState();
    print("hello");
    print(cat);
    DatabaseReference reference=FirebaseDatabase.instance.reference();
    reference.child('Products').child('Bhubaneswar').child('Electronics').once().then((DataSnapshot snap){
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
              title: Text("electronics"),
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

class electronics extends StatefulWidget {
  @override
  _electronicsState createState() => _electronicsState();
}
List n=[];
List p=[];
List im=[];
getd() async{
  n.clear();

  DatabaseReference reference=FirebaseDatabase.instance.reference();
  reference.child('Products').child('Bhubaneswar').child('Electronics').once().then((DataSnapshot snap){
    var keys=snap.key;
    var data=snap.value;
    //print(data.toString());
    //print( data);
    //print(data.toString().split(': {')[1].split(',')[1].split(': ')[1]);
    var l=data.toString().split(': {')[0].length;
    //print(data.toString().split(': {')[0].substring(1,l));
    p.clear();
    im.clear();
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
class _electronicsState extends State<electronics> {


  @override
  void initState() {
    // TODO: implement initState
    //getd();
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

*/
class e extends StatefulWidget {
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
                          context, MaterialPageRoute(builder: (context) => new item_info(prod_id2[index],imgurl1[index],name1[index],price1[index],description1[index],quantity1[index])));
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


