import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    )
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel=new Container(
      height:200.0,
      child:new Carousel(
        boxFit: BoxFit.cover,
        images:[


        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );
  Widget image_carousel1=new Container(
    height:200.00,
    child:new Carousel(
      boxFit: BoxFit.cover,
      images:[
        AssetImage('images/armani.png'),
        AssetImage('images/watches-111a.png'),
        AssetImage('images/Guide-mens-smart-casual-dress-code15@2x.png'),
        AssetImage('images/men-jeans@2x.png'),

      ],
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
    ),
  );

    return Scaffold(
      appBar: new AppBar(

        backgroundColor: Color(0xff104670), //CHECK COLOR CODE
        title: Text('Your Location \nBURLA'),

      ),
      endDrawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: Text('Ekanta'), accountEmail: null,currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                )
              ),
              decoration: new BoxDecoration(
                color: Color(0xff104670)
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(

                title: Text('Men'),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Women')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Electronics')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Sports')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Books')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Home & Furniture')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Beauty & Personal Care')
              ),
            ),

            Divider(),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('My Orders')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('My Cart')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Account')
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Notifications')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Budget')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Share')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('Settings')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('LOGOUT')
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                  title: Text('HELP')
              ),
            ),



          ],
        ),
      ),
      body:new ListView(
        children: <Widget>[
          image_carousel,
          image_carousel1
        ],
      ),
    );
  }
}
