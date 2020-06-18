import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'categories.dart';
import 'package:http/http.dart' as http;
class odetails extends StatefulWidget {
  final oid;
  odetails(this.oid);
  @override
  _odetailsState createState() => _odetailsState();
}

class _odetailsState extends State<odetails> {
  List<Pdetails> allP = [];
  @override
  void initState() {
    geto(widget.oid);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff104670),
        title: new Text("Order"),
      ),
        body:SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            child: Column(
                children: allP
                    .map(
                      (q) =>
                  new Card(
                    child: SingleChildScrollView(
                        child:InkWell(
                          child: ListTile(

                            leading:
                            new Image.network(q.img==null?"https://duckhawk.in/icon.jpeg":q.img),

                            title:new Text("Name : "+q.name,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                            subtitle: new Column(
                              children: <Widget>[
                                new Container(
                                  alignment: Alignment.topLeft,

                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),

                                      child:new Text("Total : ₹"+q.total,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                  ),
                                  /*alignment: Alignment.topLeft,
                          child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                                ),
                                new Container(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),



                                      child:new Text("Quantity : "+q.quantity,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                  ),
                                  //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                new Container(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),



                                      child:new Text("Price/Unit : "+q.price,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                  ),
                                  //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),







                              ],
                            ),

                          ),
                          onTap: (){




                          },
                        )
                    ),
                  ),

                )
                    .toList()))

    );
  }

  geto(String oi) async{
    LinkedHashMap<String, dynamic> data;
    String link1 = "https://duckhawk-1699a.firebaseio.com/Orders/" +
        loc +
        "/" +
        oi +
        "/Products" +
        ".json";
    print(link1);
    final re = await http.get(link1);
    if (re.statusCode == 200) {
      LinkedHashMap<String, dynamic> data2 = jsonDecode(re.body);
      List d = data2.values.toList();
      List keys = data2.keys.toList();
      print("keys are :");
      print(keys);
      int k = 0;
      int leng = d.length;
      while (k < leng) {
        LinkedHashMap<String, dynamic> data3 = jsonDecode(re.body)[keys[k]];
        print(data3["ProductId"]);
        print(data3["price"]);
        List p = data3.keys.toList();
        //print(p);
        int x = 0;
        while (x < keys.length) {
          String li = "https://duckhawk-1699a.firebaseio.com/Orders/" +loc.toString()+"/"+
              oi + "/Products/" + p[x] + ".json";
          //print(li);
          final re = await http.get(li);
          if (re.body != null) {
            if (re.statusCode == 200) {
              d = jsonDecode(re.body);
              //print("@####");
              //print(d["price"].);
              //print(d["quantity"]);
              String lin="https://duckhawk-1699a.firebaseio.com/Products/"+loc.toString()+"/"+data3["category"]+"/"+data3["ProductId"]+".json";
              final r=await http.get(lin);
              if(r.body!=null){
                if(r.statusCode==200){
                  data=jsonDecode(r.body);
                  print(data["ProductName"]);
                  print(data["Product_Image"]);
                  print(data["price"]);
                }
              }

            }
            Pdetails eachP = new Pdetails(
                data3["price"].toString(),
                data3["quantity"].toString(),
                data["ProductName"],
                data["Product_Image"],
                data["price"].toString()

            );
            setState(() {
              allP.add(eachP);
            });
            print("name is :");
            print(eachP.name);
          }
          x++;
        }
        /* ucat.add(data3['category']);
            uprice.add(data3['price']);
            uquantity.add(data3['quantity']);*/



        k++;
      }
    }

  }
}
class Pdetails {
  String img, name, price, total,quantity;
  var p,l;
  Pdetails(this.total, this.quantity, this.name, this.img,this.price);
}