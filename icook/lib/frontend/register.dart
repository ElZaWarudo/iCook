import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Registrarse';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
            title: Text(appTitle, style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Color(0xFF18D191))),
        body: MyCustomForm(),
      ),
    );
  }
}

// Crea un Widget Form
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  String _user, _password, _email, _name;
  final _formKey = GlobalKey<FormState>();




  bool _isRegistering= false;

  _register() async{
    if(_isRegistering) return;
    setState(() {
      _isRegistering = true;
    });

    final form = _formKey.currentState;

    if(!form.validate()){
      setState(() {
        _isRegistering=false;
      });
      return;
    }
    form.save();

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }catch(e){
      //Show

    } finally{
      setState(() {
        _isRegistering = false;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration: new InputDecoration(labelText: 'User'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo obligatorio';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              setState(() {
                _user = value;
              });
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: new InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo obligatorio';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo obligatorio';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
          TextFormField(
            decoration: new InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo obligatorio';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              setState(() {
                _name = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 36.0),
            child: new Center(
              child: RaisedButton(
                elevation: 0.0,
                animationDuration: Duration(seconds: 0),
                color: Color(0xFF18D191),
                onPressed: () {
                  _register();
                },
                child: Text('Register',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
