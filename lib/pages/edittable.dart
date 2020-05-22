import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:project_duckhawk/main.dart';
import 'package:project_duckhawk/pages/account1.dart';
class edit extends StatefulWidget {
  @override
  _editState createState() => _editState();
}
String n,p;
ProgressDialog pr;
//udetails[0]["Name"].toString();
//udetails[0]["Phone Number"].toString()
class _editState extends State<edit> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User Details"),
      ),
      body: Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextFormField(
              decoration: InputDecoration(
                hintText: 'Update Name - '+udetails[0]["Name"].toString(),
              ),
              textAlign: TextAlign.left,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Name cannot be empty';
                }
                n=text;
              },
            ),
            TextFormField(
              decoration: InputDecoration(

                hintText: 'Update Phone '+udetails[0]["Phone Number"].toString(),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.left,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Phone Number cannot be empty';
                }
                p=text;
              },
            ),
            SizedBox(

              height: 20.0,
            ),

            RaisedButton(
              onPressed: () async{
                if (_formKey.currentState.validate()) {

                  pr.show();
                  await updatedata();
                  await getuac();
                  pr.hide();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new acc1()));
                }
              },
              child: Text('Update'),
            )
          ],
        ),
      ),
    ),
      /*Container(
        child: new Column(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Container(
                  child: new Text("Name")
                ),
              ],
            ),

            new Column(
              children: <Widget>[
                Container(
                  child: new Text(udetails[0]["Name"].toString()),
                ),
              ],
            ),
            new Column(
              children: <Widget>[
                Container(
                    child: new Text("Phone")
                ),
              ],
            ),
            new Column(
              children: <Widget>[
                Container(
                  child: new Text(udetails[0]["Phone Number"].toString()),
                ),
              ],
            ),
            new Column(
              children: <Widget>[
                RaisedButton(onPressed: ()async{
                  pr.show();
                  await updatedata();
                  await getuac();
                  pr.hide();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new acc1()));
                },
                child: new Text("Update"),)
              ],
            ),



          ],
        ),

        //child: _editTitleTextField(),
      ),*/
    );
  }


  updatedata() async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    print(n);
    print(p);
    await Firestore.instance.collection('users')
        .document(user.uid)
        .updateData({
      'Name': n,
      'Phone Number':p,
    });

  }

}

