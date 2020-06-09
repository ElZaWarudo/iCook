import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Patron Provider(Observador)
class emailString with ChangeNotifier{
  String _email_p;

  String get email_p => _email_p;

  set email_p(String value) {
    _email_p = value;
    notifyListeners();
  }

  Future cargarEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email_p = prefs.getString('email');
    notifyListeners();
  }

}