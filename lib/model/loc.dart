import 'package:firebase_database/firebase_database.dart';
import 'package:project_duckhawk/pages/cart.dart';

class loc {

  double lat;
  double long;


  loc(this.lat, this.long);

  toJson() {
    return {
      "lat": lat,
      "long": long,
    };
  }
}