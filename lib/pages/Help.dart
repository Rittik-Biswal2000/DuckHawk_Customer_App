
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;




class help extends StatefulWidget {
  @override
  _helpState createState() => _helpState();
}

class _helpState extends State<help> {

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: new AppBar(
        title: new Text('Helpline Contact'),
      ),
      body: new Container(
          padding: EdgeInsets.all(16.0),

            //key: formKey,
            child: new Column(

              //crossAxisAlignment: CrossAxisAlignment.stretch,
              //children: buildInputs() + buildSubmitButtons(),
              children: <Widget>[
                Container(
                  child:

                  Text("For Any Details regarding your order call now: 6206014527",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
                ),


                RaisedButton(
                    color: Colors.redAccent,
                    child: Text(
                      'Call',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _url,
                ),
              ],
            ),
      ),
    );
  }
}

_url() async{
  if(await UrlLauncher.canLaunch("tel:6206014527"))
    UrlLauncher.launch("tel:6206014527");
  else
    print("cant call");
}