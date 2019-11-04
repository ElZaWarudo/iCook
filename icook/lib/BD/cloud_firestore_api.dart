import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icook/backend/Receta.dart';

class CloudFireStoreAPI{
  final String RECETAS = "recetas";

  final Firestore _db = Firestore.instance;

  void addReceta(Receta receta) async{
    DocumentReference ref = _db.collection(RECETAS).document(receta.id);
    return ref.setData({
      'nombre':receta.nombre,
      'descripcion':receta.descripcion,
      'id':receta.id,
      'calorias':receta.calorias,
      'tiempoPreparacion':receta.tiempoPreparacion,
      'tipo':receta.tipo,
      'hora':DateTime.now(),
      'ingredientes':receta.ingredientes,
    }, merge: true);
  }
}