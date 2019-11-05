import 'package:flutter/material.dart';
import 'package:icook/Login/login_state.dart';
import 'package:provider/provider.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
            child: Row(
              children: <Widget>[
                new Text("Loggout", style: new TextStyle(fontSize: 20.0)),
                new RaisedButton(
                  elevation: 0.0,
                  animationDuration: Duration(seconds: 0),
                  onPressed: () {
                    Provider.of<LoginState>(context).logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
