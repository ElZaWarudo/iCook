import 'package:flutter/material.dart';


class linkString with ChangeNotifier{
  String _link_p;

  String get link_p => _link_p;

  set link_p(String value) {
    _link_p = value;
  }


}