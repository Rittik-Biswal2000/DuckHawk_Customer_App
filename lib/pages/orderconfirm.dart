import 'package:flutter/material.dart';
class orderconfirm extends StatefulWidget {
  @override
  _orderconfirmState createState() => _orderconfirmState();
}

class _orderconfirmState extends State<orderconfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff104670),
        title: Text("Order"),
      ),
      body:
        new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  child: new Text("Congratulations"),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Container(
                  child: new Text("Order Confirmed"),
                ),
              ],
            ),
            Divider(),
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Continue Shopping",
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                  },
                  child: Text(
                    "View Order Summary",
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Cancel or Replace Order",
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Track Order",
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Exit",
                  ),
                )
              ],
            ),
          ],
        ),
    );
  }
}
