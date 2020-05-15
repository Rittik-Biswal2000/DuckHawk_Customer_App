import 'package:flutter/material.dart';
class summary extends StatefulWidget {
  String sname,scat,simage,sprice,squantity,sid,sseller;
  summary(this.sname,this.scat,this.simage,this.sprice,this.squantity,this.sid,this.sseller);
  @override
  _summaryState createState() => _summaryState();
}

class _summaryState extends State<summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Summary"),),
      body:
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
           child: new Row(
          children: <Widget>[
            new Row(
              children: <Widget>[
                Center(
                    child: new Text(widget.sname)
                )
              ],
            ),
            new Row(
              children: <Widget>[
                Center(
                    child: new Image.network(widget.simage)
                )
              ],
            ),
            new Row(
              children: <Widget>[
                Center(
                    child: new Image.network(widget.simage)
                )
              ],
            ),
          ],
        ),

        ),
    );
  }
}
