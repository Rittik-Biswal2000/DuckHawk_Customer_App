import 'package:flutter/material.dart';
import 'package:project_duckhawk/pages/cart.dart';
import 'package:project_duckhawk/pages/indiv_product.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/pages/product_info.dart';


class ProductInfo extends StatefulWidget {
  var product_name;
  ProductInfo({
    this.product_name,});

  @override
  _ProductInfoState createState() => _ProductInfoState(this.product_name);
}

class _ProductInfoState extends State<ProductInfo> {
  final p_name;

  _ProductInfoState(this.p_name);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(

        backgroundColor: Color(0xff104670), //CHECK COLOR CODE
        title: Text(widget.product_name),

        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,color: Colors.white,
              ),
              onPressed: (){}),
          new IconButton(
            icon: Icon(
              Icons.shopping_cart,color: Colors.white,
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>new cart()));
            },)
        ],
      ),

      body: Container(
        child: Products(this.p_name),
      ),
    );
  }
}
class Products extends StatefulWidget {
  final p_name;
  var product_list1;
  Products(this.p_name)
  {
    switch(this.p_name)
    {
      case 'Blazer':
        product_list1 = [
          {
            "name": "Blazer1",
            "picture": "images/download.png",
            "price": "₹2500"
          },
          {
            "name": "Blazer2",
            "picture": "images/download (1).png",
            "price": "₹2600"
          },
          {
            "name": "Blazer3",
            "picture": "images/download (2).png",
            "price": "₹2400"
          },
          {
            "name": "Blazer4",
            "picture": "images/download (4).png",
            "price": "₹2300"
          },
          {
            "name": "Blazer5",
            "picture": "images/download (4).png",
            "price": "₹2200"
          },
          {
            "name": "Blazer6",
            "picture": "images/download (4).png",
            "price": "₹2000"
          },

        ];
        break;
      case 'T Shirts':
        product_list1 = [
          {
            "name": "Jeans",
            "picture": "images/men-jeans@2x.png",
          },
          {
            "name": "Sneakers",
            "picture": "images/16x9.png",
          },
        ];
        break;
      default:
        product_list1 = [
          {
            "name": "Sun Glasses",
            "picture": "images/pexels-photo-46710.png",
          },
        ];

    }
  }
  @override
  _ProductsState createState() => _ProductsState(product_list1);
}

class _ProductsState extends State<Products> {
  final list_item;

  _ProductsState(this.list_item);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: list_item.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
            prod_name: list_item[index]['name'],
            prod_pricture: list_item[index]['picture'],
            prod_price: list_item[index]['price']
          );
        });
  }
}
class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_pricture,
    this.prod_price
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () => /*Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new indivProduct(prod_name,prod_pricture,prod_price))),*/
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new item_info(null,null,null,null,null,null))),
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


