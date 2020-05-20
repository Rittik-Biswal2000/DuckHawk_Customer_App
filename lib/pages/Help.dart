
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/account1.dart';
import 'package:project_duckhawk/pages/cart2.dart';
import 'package:project_duckhawk/pages/item_info.dart';
import 'package:project_duckhawk/src/welcomPage.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;




class help extends StatefulWidget {
  @override
  _helpState createState() => _helpState();
}
ProgressDialog pr;
class _helpState extends State<help> {


  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');

    return  new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xff104670),
        title: new Text('Helpline Contact'),
      ),
      bottomNavigationBar: new Container(
        padding: EdgeInsets.all(0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                icon: new Icon(Icons.shop),
                onPressed: () async{
                  //pr.show();
                  //await getData(null);
                  //pr.hide();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage(null)));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: new Icon(Icons.search),
                  onPressed: () async {

                  }),
            ),
            Expanded(
              flex: 1,
              child: IconButton (
                  icon: new Icon(Icons.account_box),
                  onPressed: () async{
                    pr.show();
                    await getuac();
                    pr.hide();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>new acc1()));
                  }),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: new Icon(Icons.shopping_cart),
                onPressed: () async {
                  pr.show();
                  await getcartData();
                  pr.hide();
                  print("Time taken");
                  stime=s.elapsedMilliseconds;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart2()));
                },),
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