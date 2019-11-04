import 'Historial.dart';

class Persona{
  String nombre, apellido, correo, usuario, contrasena;
  int tipo=0; //0=usuario 1=chef
  Historial historial;

  Persona(this.nombre, this.apellido, this.correo, this.usuario, this.contrasena);

}