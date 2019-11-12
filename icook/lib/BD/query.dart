import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:icook/backend/Receta.dart';
import 'package:icook/backend/Ingrediente.dart';
import 'package:icook/backend/providers/ingredientes_provider.dart';
import 'package:provider/provider.dart';
import 'package:icook/frontend/ver_receta.dart';

class CloudFireStoreAPI {
  static BuildContext context;
  final ingredienteString = Provider.of<IngredientesString>(context);

  BD_query(List X) {
    return Firestore.instance
        .collection('Recetas')
        .where("Ingredientes", isEqualTo: X)
        .snapshots();
  }





  Listax(String x){
    List<String> ArrayIngredientes = new List();
    x+=",";
    String palabrita="";
    for(var i=0;i<=x.length-1;i++){
      if(x[i]!=','){
        palabrita+=x[i];
      }else{
        ArrayIngredientes.add(palabrita);
        palabrita="";
      }
    }
    return ArrayIngredientes;
  }

}

