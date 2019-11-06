import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreAPI {
  BD_query(List X) {
    return Firestore.instance
        .collection('Recetas')
        //.where("Ingredientes", isEqualTo: Lista(ingredientesString.Ingredientes_p)
        .getDocuments();
  }
}
