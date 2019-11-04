import 'package:flutter/material.dart';
import 'package:icook/Login/login_state.dart';
import 'package:icook/frontend/QuickBee.dart';
import 'home.dart';
import 'package:provider/provider.dart';

void main() => runApp(First());

class First extends StatelessWidget {
  bool _loggedIn = true;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
      builder: (BuildContext context) => LoginState(),
      child: MaterialApp(
        routes: {
          '/': (BuildContext context) {
            var state = Provider.of<LoginState>(context);
            if (state.isLoggedIn()) {
              return HomePage();
            } else {
              return QuickBee();
            }
          }
        },
      ),
    );
  }
}
