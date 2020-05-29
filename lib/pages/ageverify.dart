import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project_duckhawk/pages/takephoto.dart';


class ageverify extends StatefulWidget {
  static String imagepath1;
  ageverify(String imagepath)
  {
    imagepath1 = imagepath;
  }


  @override
  _ageverifyState createState() => _ageverifyState();
}
class _ageverifyState extends State<ageverify> {
  String add = ageverify.imagepath1;

  ProgressDialog pr;
  FirebaseUser us;
  double percentage = 0.0;
  String _age;
  File file2,file1;
  String path, path1;
  StorageReference firebaseStorageRef;
  String url,url1,url2;

  String _fileName;
  String _path = 'No File Choosen';
  Map<String, String> _paths;
  String _extension;
  bool _multiPick = false;
  bool _hasValidMime = true;
  FileType _pickingType = FileType.image;

  String _fileName1;
  String _path1 = 'No File Choosen';
  Map<String, String> _paths1;
  String _extension1;
  bool _multiPick1 = false;
  bool _hasValidMime1 = true;
  FileType _pickingType1 = FileType.image;
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();



  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
    _controller1.addListener(() => _extension1 = _controller1.text);
    getuser();

  }

  void _openFileExplorer() async {
    if (_pickingType != FileType.image || _hasValidMime) {
      try {
        if (_multiPick) {
          _path = null;
          _paths = await FilePicker.getMultiFilePath(type: _pickingType);
        } else {
          _paths = null;
          _path = await FilePicker.getFilePath(type: _pickingType);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        _fileName = _path != null ? _path
            .split('/')
            .last : _paths != null ? _paths.keys.toString() : '...';
      });
    }
  }

  void _openFileExplorer1() async {
    if (_pickingType1 != FileType.image || _hasValidMime1) {
      try {
        if (_multiPick1) {
          _path1 = null;
          _paths1 = await FilePicker.getMultiFilePath(type: _pickingType1);
        } else {
          _paths1 = null;
          _path1 = await FilePicker.getFilePath(type: _pickingType1);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        _fileName1 = _path1 != null ? _path1
            .split('/')
            .last : _paths1 != null ? _paths1.keys.toString() : '...';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
print(add);
print("address");
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff104670),
          title: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: <Widget>[
                    Row(
                      children:
                      <Widget>[

                        SingleChildScrollView(
                            child: Container(
                                width: 200,
                                child: Text(
                                  "Age Verification", style: new TextStyle(
                                    fontSize: 15.0, color: Colors.white),))),
                        //child: new FlatButton(onPre,new Text("${widget.add}",style: new TextStyle(fontSize: 15.0),)))),

                      ],
                    ),
                  ],

                ),
              )
          ),
          //leading:new Text("hi"),
        ),


        body: new ListView(

          children: <Widget>[
            Container(
                padding: EdgeInsets.all(20.0),
                child: new Form(

                  //key: formKey,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildInputs() + buildSubmitButtons(),
                  ),
                )
            ),
          ],
        )
    );
  }

  List<Widget> buildInputs() {
    return [
      new ListTile(
        title: new Text("Selfie: "),
        subtitle: new Text(add),
      ),
      new Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
        child: new RaisedButton(
          onPressed: () async {
            // Ensure that plugin services are initialized so that `availableCameras()`
//                        // can be called before `runApp()`
//                        WidgetsFlutterBinding.ensureInitialized();
//
//                        // Obtain a list of the available cameras on the device.
//                        final cameras = await availableCameras();
//
//                        // Get a specific camera from the list of available cameras.
//                        final firstCamera = cameras.first;
            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraTest()),
            );
          },
          child: new Text("Take photo"),
        ),

      ),

      new Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
        child: new RaisedButton(
          onPressed: () async {
            pr.show();
            File f3 = File(add);
            firebaseStorageRef=FirebaseStorage.instance.ref().child(us.uid+"age verification"+"selfie");
            final StorageUploadTask task=firebaseStorageRef.putFile(f3);
            StorageTaskSnapshot s=await task.onComplete;
            url=await s.ref.getDownloadURL();

            print("url is "+url);
            pr.hide();


          },
          child: new Text("Upload"),
        ),
      ),
      new Text('Age Verification', textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),),
      SizedBox(height: 20.0),
      new Column(
        children: <Widget>[
          new Text('Age: '),

          new TextFormField(
            decoration: new InputDecoration(
                hintText: 'Age in years', border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey))),
            validator: (value) => value.isEmpty ? 'Age Name can\'t be empty' : null,
            onChanged: (value) {
              setState(() {
                _age = value;
              });
            },

          ),

        ],
      ),
      SizedBox(height: 20.0),
      Divider(
        color: Colors.grey,
        height: 10.0,
      ),
      new Container(
          child:
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('Front Side of Document'),
                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: new RaisedButton(
                      onPressed: () => _openFileExplorer(),
                      child: new Text("Choose File"),
                    ),
                  ),
                  new Builder(
                    builder: (BuildContext context) =>
                    _path1 != null || _paths1 != null
                        ? new Container(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.10,
                      child: new ListView.separated(
                        itemCount: _paths != null && _paths.isNotEmpty ? _paths
                            .length : 1,
                        itemBuilder: (BuildContext context, int index) {
                          final bool isMultiPath = _paths != null && _paths
                              .isNotEmpty;
                          final String name = 'File: ' + (isMultiPath ? _paths
                              .keys.toList()[index] : _fileName ?? '...');
                          path = isMultiPath ? _paths.values.toList()[index]
                              .toString() : _path;
                          file1 = new File(path);

                          return new ListTile(
                            title: new Text(
                              name,
                            ),
                            subtitle: new Text(path),
                          );
                        },
                        separatorBuilder: (BuildContext context,
                            int index) => new Divider(),
                      ),
                    )
                        : new Container(),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: new RaisedButton(
                      onPressed: () async {
                        pr.show();
                        firebaseStorageRef=FirebaseStorage.instance.ref().child(us.uid+"Age Verification"+"front");
                        final StorageUploadTask task=firebaseStorageRef.putFile(file1);
                        StorageTaskSnapshot s=await task.onComplete;
                        url1=await s.ref.getDownloadURL();

                        print("url is "+url1);
                       pr.hide();


                      },
                      child: new Text("Upload"),
                    ),
                  ),
                ],
              ),
            ),
          )),


      SizedBox(height: 20.0),
      Divider(
        color: Colors.grey,
        height: 10.0,
      ),
      new Container(
          child:
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('Back Side of Document'),
                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: new RaisedButton(
                      onPressed: () => _openFileExplorer1(),
                      child: new Text("Choose File"),
                    ),
                  ),
                  new Builder(
                    builder: (BuildContext context) =>
                    _path1 != null || _paths1 != null
                        ? new Container(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.10,
                      child: new ListView.separated(
                        itemCount: _paths1 != null && _paths1.isNotEmpty
                            ? _paths1.length
                            : 1,
                        itemBuilder: (BuildContext context, int index) {
                          final bool isMultiPath = _paths1 != null && _paths1
                              .isNotEmpty;
                          final String name = 'File: ' + (isMultiPath ? _paths1
                              .keys.toList()[index] : _fileName1 ?? '...');
                          path1 = isMultiPath ? _paths1.values.toList()[index]
                              .toString() : _path1;
                          file2 = new File(path1);

                          return new ListTile(
                            title: new Text(
                              name,
                            ),
                            subtitle: new Text(path1),
                          );
                        },
                        separatorBuilder: (BuildContext context,
                            int index) => new Divider(),
                      ),
                    )
                        : new Container(),
                  ),

                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: new RaisedButton(
                      onPressed: () async {
                        pr.show();
                       firebaseStorageRef=FirebaseStorage.instance.ref().child(us.uid+"Age Verification"+"back");
                       final StorageUploadTask task=firebaseStorageRef.putFile(file2);
                        StorageTaskSnapshot s=await task.onComplete;
                        url2=await s.ref.getDownloadURL();

                        print("url is "+url2);
                       pr.hide();


                      },
                      child: new Text("Upload"),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 10.0,
                  ),

                ],
              ),
            ),
          )),

      Divider(
        color: Colors.grey,
        height: 10.0,
      ),
    ];
  }


  List<Widget> buildSubmitButtons() {
    if (true) {
      return [
        new OutlineButton(
            child: new Text(
              'Submit for Verification', textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red),),
            onPressed: () async{
              pr.show();

              await FirebaseDatabase.instance.reference().child('AgeVerify').child(us.uid)
                  .set(
                  {
                    'DocumentBack': url2,
                    'DocumentFront': url1,
                    'SelfPhoto':url,
                    'age': _age,
                    'state':"applied"
                  }


              );
              pr.hide();
              Navigator.pop(context);

            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))
        ),
      ];
    }
  }

   getuser() async{
    us=await FirebaseAuth.instance.currentUser();

   }
}