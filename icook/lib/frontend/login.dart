import 'package:firebase_auth/firebase_auth.dart';
import 'package:icook/Login/login_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icook/frontend/register.dart';

class LoginPage extends StatelessWidget {
  final Function onLoginSuccess;

  const LoginPage({Key key, this.onLoginSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xffA60000), //or set color with: Color(0xFF0000FF)
    ));
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xffA60000))),
      body: Formulario(),
    );
  }
}

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  String _email, _contrasena;
  final _formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            height: 150.0,
            width: 150.0,
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(80.0),
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"))),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
              )
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: new TextFormField(
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
          ),
          new SizedBox(
            height: 15.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: new TextFormField(
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
                  _contrasena = value;
                });
              },
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 5.0, top: 10.0),
                  child: Consumer<LoginState>(
                    builder: (BuildContext context, LoginState value,
                        Widget child) {
                      if (value.isLoading()) {
                        return CircularProgressIndicator();
                      } else {
                        return child;
                      }
                    },
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<LoginState>(context).validateAndSubmit(validateAndSave(), _email, _contrasena);
                    },
                    child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(
                            color: Color(0xffA60000),
                            borderRadius: new BorderRadius.circular(9.0)),
                        child: new Text("Login",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white))),
                  ),
                ),),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 20.0, top: 10.0),
                  child: new Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      child: new Text("Forgot Password?",
                          style: new TextStyle(
                              fontSize: 18.0, color: Color(0xffA60000)))),
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: new Text("Create A New Account ",
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Color(0xffA60000),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
