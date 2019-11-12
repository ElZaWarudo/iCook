import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icook/backend/Ingrediente.dart';

class Receta {
  String nombre, descripcion, id, link;
  int calorias, tiempoPreparacion;
  String tipo;
  Timestamp hora;
  List<Ingrediente> ingredientes = new List<Ingrediente>();


  Receta(this.nombre, this.descripcion,  this.calorias,
      this.tiempoPreparacion, this.tipo, this.hora, this.ingredientes, this.link);

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
        Ingrediente protoIngrediente = new Ingrediente.Try(palabrita);
        ingredientes.add(protoIngrediente);
        palabrita="";
      }
    }
  }
}