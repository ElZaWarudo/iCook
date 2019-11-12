class Ingrediente{
  String nombre;
  int cantidad;
  int serial;

  Ingrediente(this.nombre, this.cantidad,
      this.serial); //1=liquidos 2=peso 3=cantidad



  Ingrediente.Try(this.nombre);



  String Serial(){
    if(serial==1){
      return "ml";
    }else{
      if(serial==2){
        return "gr";
      }else{
        return"";
      }
    }
  }


}