import 'package:flutter/material.dart';
import 'package:icook/Login/login_state.dart';
import 'package:icook/backend/providers/email_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class QuickBee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '¡COOK',
      debugShowCheckedModeBanner: false,
      // Set Raleway as the default app font
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(80.0),
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"))),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: new Color(0xffA60000),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Sign In With Email",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 5.0, top: 10.0),
                    child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(
                            color: Color(0xFF4364A1),
                            borderRadius: new BorderRadius.circular(9.0)),
                        child: new Text("Facebook",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white))),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 20.0, top: 10.0),
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
                          darle(context);
                        },
                        child: new Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: new BoxDecoration(
                                color: Color(0xFFDF513B),
                                borderRadius: new BorderRadius.circular(9.0)),
                            child: new Text("Google",
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.white))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void darle(context)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Provider.of<LoginState>(context).googleLogin();
    Provider.of<emailString>(context).email_p=prefs.getString('email');
  }
}
