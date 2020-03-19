import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_duckhawk/pages/product_details.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class products extends StatefulWidget {
  final FirebaseStorage storage = FirebaseStorage(
      app: Firestore.instance.app,
      storageBucket: 'gs://duckhawk-1699a.appspot.com');
  Uint8List imageBytes;
  String errorMsg;

  final item;
  var product_list;

  String a="pro11.jpg";
  image() {

    storage.ref().child(a).getData(10000000).then((data) =>
    {
      imageBytes = data
    }
    ).catchError((e) =>
    {
      errorMsg = e.error
    }
    );
  }

  products(this.item)
  {
    switch(this.item)
    {
      case 'fashion':
        product_list = [
          {
            "name": "Men",
            "picture": "images/Guide-mens-smart-casual-dress-code15@2x.png",
          },
          {
            "name": "Watches",
            "picture": "images/watches-111a.png",
          },
          {
            "name": "Jeans",
            "picture": "images/men-jeans@2x.png",
          },

        ];
        break;
      case 'electronics':
        image();
        var img = imageBytes != null ? Image.memory(
          imageBytes,
          fit: BoxFit.cover,
        ) : Text(errorMsg != null ? errorMsg : "Loading...");
        product_list = [
          {
            "name": a,
            "picture": "images/16x9.png",
          },
          {
            "name" : "Sun",
            "picture": img.toString(),
          },
        ];

    }
  }
  @override
  _ProductsState createState() => _ProductsState(product_list: this.product_list);


}

class _ProductsState extends State<products> {


  final product_list;

  _ProductsState({this.product_list});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              prod_name: product_list[index]['name'],
              prod_pricture: product_list[index]['picture'],
            ),
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;

  Single_prod({
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
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                    product_name: prod_name,
                  ))),
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      /*title: Text(
                        "\$$prod_price",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        "\$$prod_old_price",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            decoration
                                :TextDecoration.lineThrough),
                      ),*/
                    ),
                  ),
                  child: Image.asset(
                    prod_pricture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
