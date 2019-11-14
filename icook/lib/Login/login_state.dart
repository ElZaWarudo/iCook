import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loggedIn = false;
  bool _loading = false;


  bool get loggedIn => _loggedIn;

  set loggedIn(bool value) {
    _loggedIn = value;
  }

  bool isLoggedIn() => _loggedIn;
  bool isLoading() =>   _loading;

  void googleLogin() async{
    _loading =true;
    notifyListeners();

    var user = await _handleSignIn();

    _loading = false;
    notifyListeners();
    if(user!= null) {
      _loggedIn = true;
      notifyListeners();
      obtenerInicio();
    }else{
      _loggedIn = false;
      notifyListeners();
      obtenerInicio();
    }
  }

  void loadingFalse(){
    _loading = false;
    notifyListeners();
  }

  void validateAndSubmit(bool x, String email, String contrasena) async {
    _loading =true;
    notifyListeners();
    AuthResult Result;
    if (x){
      Result =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: contrasena).whenComplete(loadingFalse);
      print('Signed in: ${Result.user.displayName}');
    }

    if(Result.user!= null) {
      _loggedIn = true;
      notifyListeners();
      obtenerInicio();
    }else{
      _loggedIn = false;
      notifyListeners();
      obtenerInicio();
    }
  }

  void logout(){
    _googleSignIn.signOut();
    _loggedIn = false;
    notifyListeners();
    obtenerInicio();
  }

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  asd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('valorInicio', false);
  }

  void inicializar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loggedIn = await prefs.getBool('valorInicio');
    notifyListeners();
  }

  obtenerInicio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('valorInicio', _loggedIn);
  }
}
