import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icook/backend/providers/email_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
            iconTheme: new IconThemeData(color: Color(0xffA60000))),
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
  final databaseReference = Firestore.instance;
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
        guardarUsuario();
        _isRegistering = false;
      });
    }

  }

  guardarUsuario()async{
    await databaseReference.collection("Usuarios").document().setData({
      'Contraseña': _password,
      'Email': _email,
      'Nombre': _name,
      'Foto': 'https://firebasestorage.googleapis.com/v0/b/icook-a5611.appspot.com/o/user-default.jpg?alt=media&token=9d06a888-351b-40bc-9f18-3b0cd0358841',
    });
    guardarEmail();
  }

  guardarEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email);
    Provider.of<emailString>(context).email_p=prefs.getString('email');
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
                color: Color(0xffA60000),
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
