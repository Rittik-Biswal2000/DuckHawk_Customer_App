import 'package:dio/dio.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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
class _caState extends State<ca> {
  Future<List> countries;
  Future<List> getcountries() async{
    list.clear();
    quantity1.clear();
    description1.clear();
    price1.clear();
    name1.clear();
    imgurl1.clear();
    var response=await http.get("https://duckhawk-1699a.firebaseio.com/Seller/Bhubaneswar/T7n6FiUoxsbQ4JWWqFneaUXCKLZ2/products.json");
    LinkedHashMap<String, dynamic> data = jsonDecode(response.body);
     list = data.keys.toList();
    print(list);
    if (response.body != null) {
      if (response.statusCode == 200) {
        LinkedHashMap<String, dynamic> data1 = jsonDecode(response.body);
        //print("length is :");
        print(data1);
        if(data1!=null){
          List k = data1.keys.toList();

          //print(k);
          List d = data1.values.toList();

          int h = 0;
          len1 = d.length;
          while (h < d.length) {
            LinkedHashMap<String, dynamic> data2 = jsonDecode(response.body)[k[h]];
            //List x=data2.values.toList();
            //print(data2["cat"]);
            //prod_id2.add(k[h]);
            //prod_cat2.add(data2["cat"]);
            //badd

            String link2 = "https://duckhawk-1699a.firebaseio.com/Products/" +
                "Bhubaneswar" +
                "/" +
                data2["cat"] +
                "/" +
                k[h] +
                ".json";
            final resource3 = await http.get(link2);
            if (resource3.statusCode == 200) {
              LinkedHashMap<String, dynamic> data4 = jsonDecode(resource3.body);
              // print("city is:");


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

   // print(response.data);
     jdata=json.decode(response.body);
    //rint(jdata as List);
    return response.body as List;
  }
  @override
  void initState() {
    // TODO: implement initState
    //countries=getcountries();

    super.initState();
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
             future: getcountries(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
               if(jdata==null){
                 return Container(
                   child: Center(
                     child: Text("Loading....."),
                   ),
                 );
               }

              else{
                return ListView.builder(
                  itemCount: name1.length,
                    itemBuilder: (
                    BuildContext context,int index){
                  return new Text(name1[index]);

                });
              }
            },
          ),
        ),
    );
  }
}
