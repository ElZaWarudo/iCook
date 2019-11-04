import 'package:icook/BD/cloud_firestore_repository.dart';
import 'package:icook/backend/Receta.dart';



//Agregar receta
class Logica {
  final  _cloudFireStoreRepository = CloudFirestoreRepository();
  void addReceta(Receta receta) => _cloudFireStoreRepository.updateUserDataFirestore(receta);
}
