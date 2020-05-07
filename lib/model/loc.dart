import 'package:firebase_database/firebase_database.dart';
import 'package:project_duckhawk/pages/cart.dart';

class locs {

  double lat;
  double long;


  locs(this.lat, this.long);

  toJson() {
    return {
      "lat": lat,
      "long": long,
    };
  }
}