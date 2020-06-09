import 'package:icook/backend/Receta.dart';
//Patron iterador
class Iterador{
  List<Receta> _recetas;
  int _posicion;

  Iterador(List<Receta> recetas) {
    _recetas = recetas;
    _posicion = 0;
  }

  int getposicion(){
    return _posicion;
  }
  List<Receta> getrecetas(){
    return _recetas;
  }


  bool hasNext(){
    if (_posicion < _recetas.length)
      return true;
    else
      return false;
  }

  Object next(){
    Receta valor = _recetas[_posicion];
    _posicion++;
    return valor;
  }
}