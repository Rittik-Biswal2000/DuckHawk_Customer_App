import 'package:firebase_database/firebase_database.dart';
import 'package:project_duckhawk/model/Products.dart';

class Orders {
  String key;
  String Address;
  String buyer;
  String seller;
  String time;
  double total;
  String payid;

  Orders(this.Address,this.buyer, this.seller, this.time,this.total, this.payid);

  Orders.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.value["key"],
        Address = snapshot.value["Address"],
        buyer = snapshot.value["buyer"],
        seller = snapshot.value["seller"],
        time = snapshot.value["time"],
        payid=snapshot.value["payid"],
        total = snapshot.value["total"];




  toJson() {
    return {
      "key": key,
      "Address": Address,
      "buyer": buyer,
      "seller": seller,
      "time": time,
      "transaction":payid,
      "total": total
    };
  }

}