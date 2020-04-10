
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/components/horizontal_listview.dart';
import 'package:project_duckhawk/components/products.dart';
import 'package:project_duckhawk/pages/Help.dart';
import 'package:project_duckhawk/pages/account.dart';
import 'package:project_duckhawk/pages/auto.dart';

import 'package:project_duckhawk/pages/category.dart';
import 'package:project_duckhawk/pages/electronics.dart';
import 'package:project_duckhawk/pages/login_page.dart';
import 'package:project_duckhawk/pages/product_details.dart';
import 'package:project_duckhawk/pages/cart.dart';
import 'package:project_duckhawk/pages/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_duckhawk/pages/signup.dart';
import 'package:project_duckhawk/src/welcomPage.dart';
import './pages/login_page.dart';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
FirebaseUser user;
String curlat,curlon;

String badd="Loading";
List se=[];
List se_name=[];
List se_phone=[];
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


    getd();
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
    print(se_name);
    print(se_phone);
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
                          getseller();

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyLocation()));
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage(null)));
                          //_getCurrentLocation();
                          currentUser();
                        },
                      ),
                       SingleChildScrollView(

                           child: Container(
                              child: new FlatButton(onPressed: (){
                                getseller();
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


      /*



      persistentFooterButtons: <Widget>[/*
        new IconButton(icon: new Icon(Icons.add_shopping_cart), onPressed: () => _onClick('Button1')),
        new IconButton(icon: new Icon(Icons.shop), onPressed: () => _onClick('Button2')),
        new IconButton(icon: new Icon(Icons.monetization_on), onPressed: () => _onClick('Button3')),
        new IconButton(icon: new Icon(Icons.notifications), onPressed: () => _onClick('Button4')),
        new IconButton(icon: new Icon(Icons.share), onPressed: () => _onClick('Button5')),*/
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.add_shopping_cart), onPressed: () => _onClick('Button1')),
              new IconButton(icon: new Icon(Icons.shop), onPressed: () => _onClick('Button2')),
              new IconButton(icon: new Icon(Icons.monetization_on), onPressed: () => _onClick('Button3')),
              new IconButton(icon: new Icon(Icons.notifications), onPressed: () => _onClick('Button4')),
              new IconButton(icon: new Icon(Icons.share), onPressed: () => _onClick('Button5')),

            ],
          ),
        ),

      ],*/
     /* bottomNavigationBar: new Container(
        padding: EdgeInsets.all(0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                icon: new Icon(Icons.add_shopping_cart),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.shop),
                  onPressed: () => _onClick('Button2')),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.monetization_on),
                  onPressed: () => _onClick('Button3')),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.notifications),
                  onPressed: () => _onClick('Button3')),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.share),
                  onPressed: () => _onClick('Button3')),
            ),
          ],
        ),
      ),*/
      endDrawer: new Drawer(
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
      ),
      body:
        new Text("Hi")
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
        print(place.locality);
      });

        badd=_currentAddress;
        print("badd is:");
        print(badd);

    } catch (e) {
      print(e);
    }

    getseller();
  }

  getseller() {


    print("seller");
    print("badd"+_currentAddress);
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    reference.child('Seller').child(badd).once().then((DataSnapshot snapshot) {
      //print('Key : ${snapshot.key}');
     // print('Data : ${snapshot.value}');
      var l=snapshot.value.toString().split(': ')[0].length;
      //print('Data : ${snapshot.value.toString().split(': ')[0]}');
      //print('Data : ${snapshot.value.toString().split(': ')[0].substring(1,l)}');
      se.add(snapshot.value.toString().split(': ')[0].substring(1,l));
      //print('Data : ${snapshot.value.toString().split('}},')[1]}');
      //print('Data : ${snapshot.value.toString().split('}},')[1].split(': ')[0]}');
       n=snapshot.value.toString().split('}},').length;
      DatabaseReference ref1=FirebaseDatabase.instance.reference();
      for(i=1;i<n;i++)
        {
          se.add(snapshot.value.toString().split('}}, ')[i].split(':')[0]);
          ref1.child('ApplicationForSeller').child(se[i]).once().then((DataSnapshot snapshot){
            //print('Key : ${snapshot.key}');
            print('Data : ${snapshot.value}');
            pr.show();
            se_name.add(snapshot.value.toString().split(',')[3]);
            se_phone.add(snapshot.value.toString().split(',')[10]);
            pr.hide();




          });
        }
      print("se");
      print(se_name);

     /* DatabaseReference ref1=FirebaseDatabase.instance.reference();
      for( j=0;j<s.length;j++){
        ref1.child('ApplicationForSeller').child(se[j]).once().then((DataSnapshot snapshot){
          //print('Key : ${snapshot.key}');
          print('Data : ${snapshot.value}');
          se_name.add(snapshot.value.toString().split(',')[3]);
          se_phone.add(snapshot.value.toString().split(',')[10]);



        });
      }*/

      print("se is");
      print(se);







    });



    Navigator.push(context, MaterialPageRoute(builder: (context) => new Seller(),));


  }
}

class Seller extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //print("length is :");
   // print(s.length);
    return ListView.builder(
      padding:const EdgeInsets.all(8),
        itemCount: s.length,
        itemBuilder: (BuildContext context,int index){
        return Container(
          height: 50.0,
          child:Center(
            child: Text(s[index].toString()),
          ),
        );

        });
  }
}

