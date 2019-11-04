import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icook/BD/cloud_firestore_api.dart';
import 'package:icook/backend/Receta.dart';
class CloudFirestoreRepository{

  final _cloudFirestoreAPI = CloudFireStoreAPI();

  void updateUserDataFirestore(Receta receta) => _cloudFirestoreAPI.addReceta(receta);
}