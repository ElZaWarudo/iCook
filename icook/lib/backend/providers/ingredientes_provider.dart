import 'package:flutter/material.dart';


class IngredientesString with ChangeNotifier{
  String _Ingredientes_p;

  get Ingredientes_p {
    return _Ingredientes_p;
  }

  set Ingredientes_p (String Ingredientes_p){
    this._Ingredientes_p=Ingredientes_p;
  }
}