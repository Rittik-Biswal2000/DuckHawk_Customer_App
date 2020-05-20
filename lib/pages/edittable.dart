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
bool _isEditingText = false;
TextEditingController _editingController;
String initialText = udetails[0]["Name"].toString();
bool _isEditingText1 = false;
TextEditingController _editingController1;
String initialText1 = udetails[0]["Phone Number"].toString();
class _editState extends State<edit> {
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: initialText);
    _editingController1 = TextEditingController(text: initialText1);
  }
  @override
  void dispose() {
    _editingController.dispose();
    _editingController1.dispose();
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
      body: Container(
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
                  child: _editTitleTextField(),
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
                  child: _editTitleTextField2(),
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
      ),
    );
  }
  Widget _editTitleTextField() {
    if (_isEditingText)
      return Container(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            onSubmitted: (newValue){
              setState(() {
                initialText = newValue;
                n=newValue;
                _isEditingText =false;
              });
            },
            autofocus: true,
            controller: _editingController,
          ),
        ),
      );
    return InkWell(
        onTap: () {
      setState(() {
        _isEditingText = true;
      });
    },
    child: Text(
    initialText,
    style: TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    ),
    ));
  }
  Widget _editTitleTextField2() {
    if (_isEditingText1)
      return Container(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText1 = newValue;
              p=newValue;
              _isEditingText1 =false;
            });
          },
          autofocus: true,
          controller: _editingController1,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText1 = true;
          });
        },
        child: Text(
          initialText1,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
  Widget _editTitleTextField3() {
    if (_isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText = newValue;
              _isEditingText =false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
  Widget _editTitleTextField4() {
    if (_isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText = newValue;
              _isEditingText =false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
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

