import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/pages/account1.dart';
import 'package:project_duckhawk/pages/cart2.dart';
import 'package:project_duckhawk/pages/categories.dart';
import 'package:project_duckhawk/pages/electronics.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/pages/location.dart';
import 'package:project_duckhawk/src/loginPage.dart';

FirebaseUser user;
String curlat, curlon;
var len1;
var ul;

String badd = "Loading";
List se = [];
List udetails = [];
var currrentseller;
List se_name = [];
List se_phone = [];
List imgurl1 = [];
List quantity1 = [];
List price1 = [];
List name1 = [];
List description1 = [];
List prod_id2 = [];
List prod_cat2 = [];
List oid = [];
List ucat = [];
List uprice = [];
List uquantity = [];
var uname, uemail, uphone;
var address, t, tot;
var n;
int j;
var stime;
Stopwatch s = new Stopwatch();
ProgressDialog pr;

int d = 0;
String add = "hi";

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

String custadd = add;

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
  String _currentAddress;

  String name = "Login/SignUp";
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  String _value = '';
  int c;
  void _onClick(String value) => setState(() => _value = value);

  @override
  void initState() {
    //getd();
    c=0;
    super.initState();
    //getproducts();
    //getproducts1();
    //getposts();

    _getCurrentLocation();
    _getCurrentUser();
    print("Here outside async");
  }

  _getCurrentUser() async {
    _auth = FirebaseAuth.instance;
    mCurrentUser = await _auth.currentUser();
    //print("Hello" + mCurrentUser.email.toString());
    //name = mCurrentUser.email.toString();
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

    Widget _title() {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'DuckHawk',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff104670),
            ),
            children: [/*
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xff104670), fontSize: 30),
            ),
         */ ]),
      );
    }
    Widget _title1() {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Currently No shop available!',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xff104670),
          ),),
      );
    }

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
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(Icons.place),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new MyLocation()));
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage(null)));
                            //_getCurrentLocation();
                            currentUser();
                          },
                        ),
                        SingleChildScrollView(
                          child: Container(
                              child: new FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            new MyLocation()));
                                  },
                                  child: Text(
                                    widget.add == null ? loc : "${widget.add}",
                                    style: new TextStyle(
                                        fontSize: 15.0, color: Colors.white),
                                  ))),
                        )
                        //child: new FlatButton(onPre,new Text("${widget.add}",style: new TextStyle(fontSize: 15.0),)))),
                      ],
                    ),
                  ],
                ),
              )),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () async {
                pr.show();
                FirebaseUser user=await FirebaseAuth.instance.currentUser();
                pr.hide();
                if(user==null){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new lp()));
                }
                else{
                  pr.show();
                  await getcartData();
                  pr.hide();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new cart2()));
                }

              },
            ),
          ]
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
                onPressed: () async {
                  //pr.show();
                  //await getData(null);
                  //pr.hide();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new HomePage(null)));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.search), onPressed: () async {}),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.account_box),
                  onPressed: () async {
                    pr.show();
                    FirebaseUser user=await FirebaseAuth.instance.currentUser();
                    print(user);
                    pr.hide();
                    if(user==null){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => new lp()));

                    }
                    else{
                      pr.show();
                      await getuac();
                      pr.hide();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => new acc1()));
                    }


                  }),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: new Icon(Icons.shopping_cart),
                onPressed: () async {
                  pr.show();
                  FirebaseUser user=await FirebaseAuth.instance.currentUser();
                  pr.hide();
                  if(user==null){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new lp()));
                  }
                  else{
                    pr.show();
                    await getcartData();
                    pr.hide();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new cart2()));
                  }

                },
              ),
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
      body: WillPopScope(
          //onWillPop: _onBackPressed,
          child: Builder(
              builder: (context){
                if(fsellerlist.isNotEmpty) {
                  return Container(
                    child: new ListView.builder(
                        itemCount: fsellerlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          //currrentseller=sellerlist[index];
                          if (fsellerlist.isNotEmpty) {
                            return new Card(
                                child: SingleChildScrollView(
                                    child: InkWell(
                                      onTap: () async {
                                        pr.show();
                                        await getproductdetails(fprod_id[index]);
                                        pr.hide();
                                        if(imgurl1.isNotEmpty){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    e(fsellerlist[index])),
                                          );
                                        }
                                        else{
                                          Fluttertoast.showToast(
                                              msg: "Sorry ! No products Available",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              //backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 8.0
                                          );
                                        }

                                        // Navigator.pop(context);
                                      },
                                      child: ListTile(
                                        leading:
                                        new Image.network(fshop_image[index],width:100.0,height:400.0),
                                        title: new Text(fowner_name[index]),
                                        subtitle: new Column(
                                          children: <Widget>[
                                            new Container(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child:
                                                new Text("Contact - " +
                                                    fowner_phone[index]),
                                              ),
                                            ),
                                            new Container(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: new Text("Distance - " +
                                                    distance[index]),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                ));
                          }
                        }),
                  );
                }
                else
                {
                  return new Container(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _title(),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: _title1(),
                                  )
                                ],
                              ),
                              //_facebookButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })


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

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit an App'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            )
          ],
        );
      },
    ) ??
        false;
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
      curlat = _currentPosition.latitude.toString();
      curlon = _currentPosition.longitude.toString();
      print("Coordinates are :");

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}";
        print(place.postalCode);
      });

      badd = _currentAddress;
      print("badd is:");
      print(badd);
    } catch (e) {
      print(e);
    }
  }
}

getuac() async {
  udetails.clear();
  oid.clear();
  ucat.clear();
  uquantity.clear();
  uprice.clear();
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  print("uac");
  await Firestore.instance
      .collection("users")
      .where("uid", isEqualTo: user.uid)
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    //snapshot.documents.forEach((f) => print('${f.data}}'));
    snapshot.documents.forEach((f) => udetails.add(f.data));

    //print(s.length);
    //print(s.split(',')[0]);
    //print(s.split(',')[1]);
    //print(s.split(',')[2]);
    //print(s.split(',')[3]);
    //

    //print("s is " + s);

    //g = s.toString();
  });
  /*
 await Firestore.instance.collection('users').document(user.uid).collection('orders').getDocuments().then((QuerySnapshot snapshot){
   snapshot.documents.forEach((f)=>oid.add(f.documentID));
 });
 print("oid are :");
for(var i=0;i<oid.length;i++)
  {
    String link="https://duckhawk-1699a.firebaseio.com/Orders/"+loc+"/"+oid[i]+".json";
    print(link);
    final r=await http.get(link);
    if(r.statusCode==200)
      {
        LinkedHashMap<String,dynamic>data1=jsonDecode(r.body);
        address=data1['Address'];
        t=data1['time'];
        tot=data1['total'];

        String link1="https://duckhawk-1699a.firebaseio.com/Orders/"+loc+"/"+oid[i]+"/Products"+".json";
        //print(link1);
        final re=await http.get(link1);
        if(re.statusCode==200)
          {
            LinkedHashMap<String,dynamic>data2=jsonDecode(re.body);
            List d=data2.values.toList();
            List keys=data2.keys.toList();
            int k=0;
            int leng=d.length;
            while(k<leng)
              {
                LinkedHashMap<String, dynamic> data3 = jsonDecode(re.body)[keys[k]];
                ucat.add(data3['category']);
                uprice.add(data3['price']);
                uquantity.add(data3['quantity']);

                k++;

              }

          }


      }
  }
print(ucat);
print(uprice);
print(uquantity);
*/
}

getorderdetails() async {
  oid.clear();
  ucat.clear();
  uquantity.clear();
  uprice.clear();
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  await Firestore.instance
      .collection('users')
      .document(user.uid)
      .collection('orders')
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) => oid.add(f.documentID));
  });
  print("oid are :");
  for (var i = 0; i < oid.length; i++) {
    String link = "https://duckhawk-1699a.firebaseio.com/Orders/" +
        loc +
        "/" +
        oid[i] +
        ".json";
    print(link);
    final r = await http.get(link);
    if (r.statusCode == 200) {
      LinkedHashMap<String, dynamic> data1 = jsonDecode(r.body);
      address = data1['Address'];
      t = data1['time'];
      tot = data1['total'];

      String link1 = "https://duckhawk-1699a.firebaseio.com/Orders/" +
          loc +
          "/" +
          oid[i] +
          "/Products" +
          ".json";
      //print(link1);
      final re = await http.get(link1);
      if (re.statusCode == 200) {
        LinkedHashMap<String, dynamic> data2 = jsonDecode(re.body);
        List d = data2.values.toList();
        List keys = data2.keys.toList();
        int k = 0;
        int leng = d.length;
        while (k < leng) {
          LinkedHashMap<String, dynamic> data3 = jsonDecode(re.body)[keys[k]];
          ucat.add(data3['category']);
          uprice.add(data3['price']);
          uquantity.add(data3['quantity']);

          k++;
        }
      }
    }
  }
}
var pro;
getproductdetails(String id) async {
  imgurl1.clear();
  quantity1.clear();
  price1.clear();
  name1.clear();
  description1.clear();
  prod_id2.clear();
  prod_cat2.clear();
  String link = "https://duckhawk-1699a.firebaseio.com/Seller/" +
      loc +
      "/" +
      id +
      "/products.json";
  final resource = await http.get(link);
  print("link is :");
  print(link);
  print(resource.body);
  pro = resource.body;
  print(pro);
  if (pro.toString() == null) {
    print("hi");
  }

  if (resource.body != null) {
   if (resource.statusCode == 200) {
     LinkedHashMap<String, dynamic> data1 = jsonDecode(resource.body);
     //print("length is :");
     //print(data1.length);
     if(data1!=null){
     List k = data1.keys.toList();

     //print(k);
     List d = data1.values.toList();

     int h = 0;
     len1 = d.length;
     while (h < d.length) {
       LinkedHashMap<String, dynamic> data2 = jsonDecode(resource.body)[k[h]];
       //List x=data2.values.toList();
       //print(data2["cat"]);
       prod_id2.add(k[h]);
       prod_cat2.add(data2["cat"]);
       //badd

       String link2 = "https://duckhawk-1699a.firebaseio.com/Products/" +
           loc +
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
}
