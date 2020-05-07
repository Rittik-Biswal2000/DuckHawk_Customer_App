import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class cart1 extends StatefulWidget {
  @override
  _cart1State createState() => _cart1State();
}

class _cart1State extends State<cart1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body:Center(
        child: DelayedList(),
      ),

    );
  }
}
class DelayedList extends StatefulWidget {
  @override
  _DelayedListState createState() => _DelayedListState();
}

class _DelayedListState extends State<DelayedList> {
  bool isLoading=true;

  @override
  Widget build(BuildContext context)  {
    Timer timer=Timer(Duration(seconds: 3),(){
      setState(() {
        isLoading=false;
      });
    });
    return isLoading?ShimmerList():DataList(timer);
  }
}
class DataList extends StatelessWidget {
  final Timer timer;
  DataList(this.timer);
  @override
  Widget build(BuildContext context) {
    timer.cancel();
    return ListView.builder(
      itemCount: 8,
        itemBuilder: (context,i){
        return Container(
          padding: EdgeInsets.all(15),
          child: Text(i.toString()),

        );

        });
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset=0;
    int time=800;
    return SafeArea(
      child: ListView.builder(
        itemCount: 6,
          itemBuilder:(BuildContext context,int index) {
          offset+=5;
          time=800+offset;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Shimmer.fromColors(highlightColor:Colors.white,baseColor: Colors.grey,child: ShimmerLayout(),
            period:Duration(milliseconds: time),),
          );
          }),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerwidth=200;
    double containerHeight=50;
    return Container(
      margin:EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 100,
            width:80,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: containerHeight,
                width: containerwidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerwidth*0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
