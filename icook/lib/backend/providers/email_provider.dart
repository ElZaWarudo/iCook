import 'package:flutter/material.dart';


class emailString with ChangeNotifier{
  String _email_p;

  String get email_p => _email_p;

  set email_p(String value) {
    _email_p = value;
    notifyListeners();
  }


}