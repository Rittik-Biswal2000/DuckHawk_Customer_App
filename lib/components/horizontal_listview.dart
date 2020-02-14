import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/16x9.png',
            image_caption: 'shoes',
          ),

          Category(
            image_location: 'images/men-jeans.png',
            image_caption: 'riitik',
          ),

          Category(
            image_location: 'images/16x9.png',
            image_caption: 'shoes',
          ),

          Category(
            image_location: 'images/16x9.png',
            image_caption: 'shoes',
          ),



          Category(
            image_location: 'images/16x9.png',
            image_caption: 'shoes',
          ),



        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;
  Category({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
          onTap: () {},
            child: Container(
              width: 100.0,
              child: ListTile(
                title: Image.asset(image_location,width: 80.0, height: 50.0,),
                subtitle: Container(
                  alignment: Alignment.topCenter,
                    child: Text(image_caption, style: new TextStyle(fontSize: 12.0),),
                ),
              ),
            )
          ),
    );
  }
}
