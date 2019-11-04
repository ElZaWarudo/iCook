import 'package:flutter/material.dart';
import 'package:icook/backend/Ingrediente.dart';

class Receta {
  String nombre, descripcion, id;
  int calorias, tiempoPreparacion;
  String tipo;
  DateTime hora;
  List<Ingrediente> ingredientes = new List<Ingrediente>();

  Receta ({
    Key key,
    @required this.nombre,
    @required this.descripcion,
    @required this.calorias,
    @required this.tiempoPreparacion,
    @required this.tipo,
    @required this.hora,
  });

  Receta.Try({
    Key key,
    @required this.nombre,
    @required this.descripcion,
    @required this.calorias,
    @required this.tiempoPreparacion,
    @required this.tipo,
  });

  Receta.Prototype (int calorias, int tiempoPreparacion, String tipo, List ingredientes){
    this.calorias= calorias;
    this.tiempoPreparacion=tiempoPreparacion;
    this.tipo=tipo;
    this.ingredientes=ingredientes;
  }
  void addIngredient(Ingrediente ingrediente){
    ingredientes.add(ingrediente);
  }

  void ordenarIngredientes(){
    ingredientes.sort();
  }


  void AgregarIngredientes(String ing){
    ing+=",";
    String palabrita="";
    for(var i=0;i<=ing.length-1;i++){
      if(ing[i]!=','){
        palabrita+=ing[i];
      }else{
        Ingrediente protoIngrediente = new Ingrediente(palabrita);
        ingredientes.add(protoIngrediente);
        palabrita="";
      }
    }
  }
}