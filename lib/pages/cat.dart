import 'package:dio/dio.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_duckhawk/pages/categories.dart';
class ca extends StatefulWidget {
  @override
  _caState createState() => _caState();
}
var jdata;
List list=[];
List quantity1=[];
List price1=[];
List name1=[];
List description1=[];
List imgurl1=[];
var len1;
var lll;
ScrollController _scrollController=ScrollController();
bool _gettingMoreProduts=false;
bool _moreProductsavailable=true;
Future<List> countries;
Future<void> getcountries() async{
  list.clear();
  quantity1.clear();
  description1.clear();
  price1.clear();
  name1.clear();
  imgurl1.clear();
  //var response=await http.get("https://duckhawk-1699a.firebaseio.com/Seller/Bhubaneswar/T7n6FiUoxsbQ4JWWqFneaUXCKLZ2/products.json");
  LinkedHashMap<String, dynamic> data = jsonDecode(response.body);
  list = data.keys.toList();
  print("Type is :");
  print(response.runtimeType);
  if (response.body != null) {
    if (response.statusCode == 200) {
      LinkedHashMap<String, dynamic> data1 = jsonDecode(response.body);
      print("data1 is :");
      if(data1!=null){
        List k = data1.keys.toList();
        print("k is");

        print(k);
        List d = data1.values.toList();
        lll=d.length;
        int h = 0;
        len1=6;
        print(len1);
        while (h < len1) {
          LinkedHashMap<String, dynamic> data2 = jsonDecode(response.body)[list[h]];
          String link2 = "https://duckhawk-1699a.firebaseio.com/Products/" + "Bhubaneswar" + "/" + data2["cat"] + "/" +
              k[h] +
              ".json";
          final resource3 = await http.get(link2);
          if (resource3.statusCode == 200) {
            LinkedHashMap<String, dynamic> data4 = jsonDecode(resource3.body);
            quantity1.add(data4["stock"]);
            price1.add(data4["price"]);
            name1.add(data4["ProductName"]);
            description1.add(data4["ProductDesc"]);
            if (data4["Product_Image"] == null) {
              imgurl1.add("https://duckhawk.in/icon.jpeg");
            }
            else {
              imgurl1.add(data4["Product_Image"]);
            }
          }
          h++;
        }
      }
    }
  }
  print(name1);


  //jdata=json.decode(response.body);

}
Future<void> moregetcountries() async{
  /*if(_moreProductsavailable==false)
    return;*/
  //_gettingMoreProduts=true;
  print("More called");
  int c=len1;

  //var response=await http.get("https://duckhawk-1699a.firebaseio.com/Seller/Bhubaneswar/T7n6FiUoxsbQ4JWWqFneaUXCKLZ2/products.json");
  LinkedHashMap<String, dynamic> data = jsonDecode(response.body);
  list = data.keys.toList();
  print("Type is :");
  print(response.runtimeType);
  if (response.body != null) {
    if (response.statusCode == 200) {
      LinkedHashMap<String, dynamic> data1 = jsonDecode(response.body);
      print("data1 is :");
      if(data1!=null){
        List k = data1.keys.toList();
        print("k is");

        print(k);
        List d = data1.values.toList();
        int h = c;
        len1=c+10;
        /*if(c>=d.length)
          _moreProductsavailable=false;*/
        while (h < len1) {
          LinkedHashMap<String, dynamic> data2 = jsonDecode(response.body)[list[h]];
          String link2 = "https://duckhawk-1699a.firebaseio.com/Products/" + "Bhubaneswar" + "/" + data2["cat"] + "/" +
              k[h] +
              ".json";
          final resource3 = await http.get(link2);
          if (resource3.statusCode == 200) {
            LinkedHashMap<String, dynamic> data4 = jsonDecode(resource3.body);
            quantity1.add(data4["stock"]);
            price1.add(data4["price"]);
            name1.add(data4["ProductName"]);
            description1.add(data4["ProductDesc"]);
            if (data4["Product_Image"] == null) {
              imgurl1.add("https://duckhawk.in/icon.jpeg");
            }
            else {
              imgurl1.add(data4["Product_Image"]);
            }
          }
          h++;
        }
      }
    }
  }
  print(name1);
  //_gettingMoreProduts=false;


  //jdata=json.decode(response.body);

}
class _caState extends State<ca> {





  @override
  void initState() {
    //moregetcountries();
    /*_scrollController.addListener(() {
      double maxScroll=_scrollController.position.maxScrollExtent;
      print(maxScroll);
      double currentScroll=_scrollController.position.pixels;
      print(currentScroll);
      double delta=MediaQuery.of(context).size.height*0.25;
      if(maxScroll-currentScroll<=delta){
        moregetcountries();
      }
    });*/
    // TODO: implement initState
    //countries=getcountries();


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("cat"),
      ),
      body:
        Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
             //future: getcountries(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
               if(jdata==null){
                 return Container(
                   child: Center(
                     child: Text("Loading....."),
                   ),
                 );
               }

              else{
                /*return ListView.builder(
                  itemCount: name1.length,
                    itemBuilder: (
                    BuildContext context,int index){
                  return new Text(name1[index]);

                })*/
                 return ListView.builder(
                   //controller: _scrollController,
                   itemCount: name1.length,
                   itemBuilder: (BuildContext context,int index){

                     return new Card(
                       child: SingleChildScrollView(
                           child:InkWell(
                             child: ListTile(

                               leading:
                               new Image.network(imgurl1[index],width:100.0,height:400.0),

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


                                 ],
                               ),

                             ),
                             onTap: (){

                               /*Navigator.push(
                                   context, MaterialPageRoute(builder: (context) => new item_info(widget.s,prod_cat2[index],prod_id2[index],imgurl1[index],name1[index],price1[index],description1[index],quantity1[index])));*/



                             },
                           )
                       ),
                     );
                   },



                 );
              }
            },
          ),
        ),
    );
  }
}
