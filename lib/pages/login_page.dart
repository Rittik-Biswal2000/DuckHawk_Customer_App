import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_duckhawk/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_duckhawk/main.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
enum FormType{
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  final DBRef = FirebaseDatabase.instance.reference().child('\User');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;
  String _phone,_seller;
  FormType _formType = FormType.login;

  bool validateandSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
  void writeData(){
    final DBRef = FirebaseDatabase.instance.reference().child('User');

    DBRef.push().set({
      'name':_name,
      'email':_email,
      'number':_phone,
      'isSeller':_seller,

    });

  }
  Future<void> validateandSubmit() async {
    if (validateandSave()) {
      try {
        if (_formType == FormType.login) {
          //FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;
          final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: _email, password: _password)).user;
          //FirebaseUser user = await FirebaseAuth.instance .signInWithEmailAndPassword(email: _email, password: _password);
          //final FirebaseUser user = (await _auth.signInWithEmailAndPassword(email:_email,password: _password).user;
          if (user != null) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => new HomePage(null)));
            print("hello"+user.displayName);
          }
          return user;
        }
        else {
          writeData();
          FirebaseUser user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _email, password: _password)) as FirebaseUser;




        }
      }
      catch (e) {

      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInputs() + buildSubmitButtons(),
            ),
          )
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'password'),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: validateandSubmit,
        ),
        new FlatButton(
          child: new Text(
              'Create an account', style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),
      ];
    }
    else {
      return [
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Name'),
          validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
          onSaved: (value) => _name = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Phone Number'),
          validator: (value) => value.isEmpty ? 'Phone Number can\'t be empty' : null,
          onSaved: (value) => _phone = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Are you a seller ?'),
          validator: (value) => value.isEmpty ? 'Enter true/false' : null,
          onSaved: (value) => _seller = value,
        ),
        new RaisedButton(
          child: new Text(
              'Create an Account', style: new TextStyle(fontSize: 20.0)),
          onPressed: validateandSubmit,
        ),
        new FlatButton(
          child: new Text(
              'Have an Account ? Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        )

      ];
    }
  }
}
