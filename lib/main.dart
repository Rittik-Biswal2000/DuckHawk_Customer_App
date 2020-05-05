
import 'dart:collection';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/components/horizontal_listview.dart';

import 'package:project_duckhawk/pages/Help.dart';
import 'package:project_duckhawk/pages/account.dart';

import 'package:project_duckhawk/pages/electronics.dart';
import 'package:project_duckhawk/pages/login_page.dart';

import 'package:project_duckhawk/pages/cart.dart';
import 'package:project_duckhawk/pages/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_duckhawk/pages/signup.dart';
import 'package:project_duckhawk/src/welcomPage.dart';
import './pages/login_page.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
FirebaseUser user;
String curlat,curlon;
var len1;

String badd="Loading";
List se=[];
var currrentseller;
List se_name=[];
List se_phone=[];
List imgurl1=[];
List quantity1=[];
List price1=[];
List name1=[];
List description1=[];
List prod_id2=[];
List prod_cat2=[];
var n;
int j;
ProgressDialog pr;


int d=0;
String add="hi";

/*void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
      //home:LoginPage()));


      home: HomePage(null)));
}*/

class HomePage extends StatefulWidget {
String add;
  HomePage(this.add);
  //HomePage(this.add);


  @override
  _HomePageState createState() => _HomePageState();
}
String custadd=add;
Future<void> currentUser() async {
  user = await FirebaseAuth.instance.currentUser();
  print(user.email);
  print(user.uid);
  print(user.displayName);
  return user;
}

class _HomePageState extends State<HomePage> {

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress ;
  String name="Login/SignUp";
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  String _value = '';
  void _onClick(String value) => setState(() => _value = value);
  @override
  void initState(){


    //getd();
    super.initState();
    //getproducts();
    //getproducts1();
    //getposts();
    cart();


    _getCurrentLocation();
    _getCurrentUser();
    print("Here outside async");

  }
  _getCurrentUser()async{
    _auth=FirebaseAuth.instance;
    mCurrentUser=await _auth.currentUser();
    print("Hello"+mCurrentUser.email.toString());
    name=mCurrentUser.email.toString();

  }
  _signOut() async {
    await _auth.signOut();
  }


  @override
  Widget build(BuildContext context) {
    print("in Main Page");
    //print(owner_name);
    //print(owner_phone);
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');

   /*
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [AssetImage('images/armani.png')],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );
    Widget image_carousel1 = new Container(
      height: 180.00,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          Image.asset('images/armani.png'),
          Image.asset('images/watches-111a.png'),
          Image.asset('images/Guide-mens-smart-casual-dress-code15@2x.png',width: 150),
          Image.asset('images/men-jeans@2x.png'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotBgColor: Colors.transparent,
      ),
    );*/

    return Scaffold(
      appBar: new AppBar(
            backgroundColor: Color(0xff104670),
        automaticallyImplyLeading: false,
            title: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Column(
                  children: <Widget>[
                    Row(
                      children:
                     <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.place),
                        onPressed: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyLocation()));
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage(null)));
                          //_getCurrentLocation();
                          currentUser();
                        },
                      ),
                       SingleChildScrollView(

                           child: Container(
                              child: new FlatButton(onPressed: (){

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyLocation()));
                              }, child: Text(widget.add==null?badd:"${widget.add}",style: new TextStyle(fontSize: 15.0, color: Colors.white),))),
                       )
                             //child: new FlatButton(onPre,new Text("${widget.add}",style: new TextStyle(fontSize: 15.0),)))),


                    ],
                  ),
              ],

            ),
                )
            ),
        //leading:new Text("hi"),


          ),






     /* persistentFooterButtons: <Widget>[
        new IconButton(icon: new Icon(Icons.shop), onPressed: () => _onClick('Button1')),
        new IconButton(icon: new Icon(Icons.search), onPressed: () => _onClick('Button2')),
        new IconButton(icon: new Icon(Icons.account_box), onPressed: () => _onClick('Button3')),
        new IconButton(icon: new Icon(Icons.shopping_cart), onPressed: () => _onClick('Button4')),
       // new IconButton(icon: new Icon(Icons.share), onPressed: () => _onClick('Button5')),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.shop), onPressed: () => _onClick('Button1')),
              new IconButton(icon: new Icon(Icons.search), onPressed: () => _onClick('Button2')),
              new IconButton(icon: new Icon(Icons.account_box), onPressed: () => _onClick('Button3')),
              new IconButton(icon: new Icon(Icons.shopping_cart), onPressed: () => _onClick('Button4')),
              //new IconButton(icon: new Icon(Icons.share), onPressed: () => _onClick('Button5')),

            ],
          ),
        ),

      ],*/
      bottomNavigationBar: new Container(
        padding: EdgeInsets.all(0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                icon: new Icon(Icons.shop),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.search),
                  onPressed: () => _onClick('Button2')),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.account_box),
                  onPressed: () => _onClick('Button3')),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.shopping_cart),
                  onPressed: () => _onClick('Button3')),
            ),
            /*Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.share),
                  onPressed: () => _onClick('Button3')),
            ),*/
          ],
        ),
      ),
     /* endDrawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            InkWell(
              child: new UserAccountsDrawerHeader(


                accountName: Text(name),
                accountEmail: null,
                currentAccountPicture: GestureDetector(
                    child: new CircleAvatar(
                      //backgroundImage: ImageProvider("images/men-jeans@2x.png"),
                      backgroundColor: Colors.grey,
                    )),
                decoration: new BoxDecoration(color: Color(0xff104670)),
              ),
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>new LoginPage()));
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new account()));
              },
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Groceries")));
              },
              child: ListTile(
                title: Text('Groceries'),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Fashion")));

              },
              child: ListTile(
                title: Text('Fashion'),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Electronics")));
              },
              child: ListTile(title: Text('Electronics')),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Sports")));
              },
              child: ListTile(title: Text('Sports')),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Books")));
              },
              child: ListTile(title: Text('Books')),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Home & Furniture")));
              },
              child: ListTile(title: Text('Home & Furniture')),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new category("Beauty & Personal Care")));
              },
              child: ListTile(title: Text('Beauty & Personal Care')),
            ),
            Divider(),
            Container(
                color: Color(0xffaaaaaa),
                child: new Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('My Orders')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));
                      },
                      child: ListTile(title: Text('My Cart')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new account()));
                      },
                      child: ListTile(title: Text('Account')),
                    ),
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Notifications')),
                    ),*/
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Budget')),
                    ),*/
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Share')),
                    ),*/
                    /*InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Settings')),
                    ),*/
                    InkWell(
                      onTap: () {
                        _signOut();

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new WelcomePage()));
                        name="Login";
                      },
                      child: ListTile(title: Text('Logout')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new help()));
                      },
                      child: ListTile(title: Text('Help')),
                    )
                  ],
                )),
          ],
        ),
      ),*/
      body:Container(
        child:new ListView.builder(
          itemCount: length,
            itemBuilder: (BuildContext context,int index){
            //currrentseller=sellerlist[index];
            return new Card(
              child:SingleChildScrollView(
                child:InkWell(
                  onTap: ()async{
                    pr.show();
                    await getproductdetails(prod_id[index]);
                    pr.hide();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => e(sellerlist[index])),
                    );
                   // Navigator.pop(context);


                  },
                  child: ListTile(
                    title: new Text(fowner_name[index]),
                    subtitle: new Column(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: new Text("Contact - "+fowner_phone[index]),
                          ),
                        ),
                        new Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: new Text("Distance - "+distance[index]),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              )
            );
            }),
      ),
      /*
      new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(2.0),
          ),
          HorizontalList(),
          new Padding(padding: const EdgeInsets.all(8.0)),
          image_carousel,
          image_carousel1,
          /*Container(
              padding: const EdgeInsets.all(10.0),
              color: Color(0xff104670),
              child: new Row(
                children: <Widget>[
                  new Icon(

                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  new Text(

                    'Fashion',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),

                ],
              )),
          Container(
            height:120.0,
            child: products(
              'fashion',
            ),
          ),*/
          Container(
              padding: const EdgeInsets.all(10.0),
              color: Color(0xff104670),
              child: new Row(
                children: <Widget>[
                  new Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  new Text(
                    'Electronics',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              )),

          /*new Padding(padding: const EdgeInsets.all(20.0),
            child:new Text('Electronics'
            ) ,),*/

          Container(
            //height:120.0,
            child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new electronics()));
                },
                child: Container(
                  //width: 100.0,
                  child: ListTile(
                    title: Image.asset('images/speaker.jpg', height: 70.0,),
                    subtitle: Container(
                      alignment: Alignment.topCenter,
                      child: Text('Speakers', style: new TextStyle(fontSize: 12.0),),
                    ),
                  ),
                )
            ),
            //child: products('electronics'),
             /*child:InkWell(
              /*onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                    product_name: prod_name,
                  ))),*/
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        "Speakers",
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
                    'images/speaker.jpg',width: 40.0,
                    fit: BoxFit.cover,
                  )),
            ),*/
          ),
        ],
      ),*/
    );
  }

  _getCurrentLocation() {

    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    d++;
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      curlat=_currentPosition.latitude.toString();
      curlon=_currentPosition.longitude.toString();
      print("Coordinates are :");

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}";
        print(place.postalCode);
      });

        badd=_currentAddress;
        print("badd is:");
        print(badd);

    } catch (e) {
      print(e);
    }


  }




}
getproductdetails(String id) async{
  imgurl1.clear();
  quantity1.clear();
  price1.clear();
  name1.clear();
  description1.clear();
  prod_id2.clear();
  prod_cat2.clear();
  String link="https://duckhawk-1699a.firebaseio.com/Seller/"+badd+"/"+id+"/products.json";
  final resource=await http.get(link);
  if(resource.statusCode==200)
  {
    LinkedHashMap<String,dynamic>data1=jsonDecode(resource.body);
    List k=data1.keys.toList();
    //print(k);
    List d=data1.values.toList();
    //print(d);
    int h=0;
    len1=d.length;
    while(h<d.length){
      LinkedHashMap<String, dynamic> data2 = jsonDecode(resource.body)[k[h]];
      //List x=data2.values.toList();
      //print(data2["cat"]);
      prod_id2.add(k[h]);
      prod_cat2.add(data2["cat"]);

      String link2="https://duckhawk-1699a.firebaseio.com/Products/"+badd+"/"+data2["cat"]+"/"+k[h]+".json";
      print(link2);
      final resource3 = await http.get(link2);
      if(resource3.statusCode == 200)
      {
        LinkedHashMap<String,dynamic>data4=jsonDecode(resource3.body);
        // print("city is:");
        imgurl1.add(data4["imgurl"]);
        quantity1.add(data4["quantity"]);
        price1.add(data4["price"]);
        name1.add(data4["name"]);
        description1.add(data4["description"]);



      }
      h++;

    }


  }
  print(imgurl1);
  print(quantity1);
  print(price1);
  print(name1);
  print(prod_id2);
  print(prod_cat2);


}



