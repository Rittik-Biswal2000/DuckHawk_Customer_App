import 'package:firebase_database/firebase_database.dart';
import 'package:project_duckhawk/pages/cart2.dart';

class Products {

  String ProductId;
  String category;
  String city;
  double price;
  double quantity;
  String seller;


  Products(this.ProductId, this.category, this.city,this.price,this.quantity,this.seller);

  toJson() {
    return {
      "ProductId": ProductId,
      "category": category,
      "city": city,
      "price": price,
      "quantity": quantity,
      "seller": seller
    };
  }
}