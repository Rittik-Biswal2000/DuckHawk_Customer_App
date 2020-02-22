import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: new AppBar(
        title: new Text('Register'),
      ),
      body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(

            //key: formKey,
            child: new Column(

              //crossAxisAlignment: CrossAxisAlignment.stretch,
              //children: buildInputs() + buildSubmitButtons(),
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: new InputDecoration(labelText: 'Email'),
                    onChanged: (val) {
                      setState(() => email = val
                      );
                    }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: new InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val

                    );
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.redAccent,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      print(email);
                      print(password);
                    }
                ),
                new FlatButton(
                  child: new Text(
                      'Login', style: new TextStyle(fontSize: 20.0)),
                  onPressed: (){},
                ),
              ],
            ),
          )
      ),
    );
  }
}
