import '../Receta.dart';
//Patron Singleton
class Singleton {

  Receta _receta;
  static Singleton _singleton;

  static Singleton getSingleton(Receta receta) {

    if (_singleton==null) {

      _singleton=new Singleton(receta);
    }
    return _singleton;
  }

  Singleton(Receta receta){
    _receta=receta;
  }


  Receta get receta => _receta;

  set receta(Receta value) {
    _receta = value;
  }

}