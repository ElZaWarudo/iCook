import 'package:flutter/material.dart';
import 'package:icook/Login/login_state.dart';
import 'package:icook/backend/providers/email_provider.dart';
import 'package:icook/backend/providers/ingredientes_provider.dart';
import 'package:icook/backend/providers/link_provider.dart';
import 'package:icook/frontend/QuickBee.dart';
import 'frontend/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(First());

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginState(),
      child: ChangeNotifierProvider(
        create: (context) => IngredientesString(),
        child: ChangeNotifierProvider(
          create: (context) => linkString(),
          child: ChangeNotifierProvider(
            create: (context) => emailString(),
            child: MaterialApp(
              routes: {
                '/': (BuildContext context) {
                  if (Provider.of<LoginState>(context).loggedIn == null) {
                    Provider.of<LoginState>(context).loggedIn = false;
                    Provider.of<LoginState>(context).obtenerInicio();
                  }
                  if (Provider.of<emailString>(context).email_p == null) {
                    Provider.of<emailString>(context).email_p = '';
                  }
                  Provider.of<emailString>(context).cargarEmail();
                  Provider.of<LoginState>(context).inicializar();
                  var state = Provider.of<LoginState>(context);
                  if (state.isLoggedIn()) {
                    return HomePage();
                  } else {
                    return QuickBee();
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
