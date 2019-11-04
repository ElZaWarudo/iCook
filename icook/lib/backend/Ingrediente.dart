class Ingrediente{
  String nombre;
  int cantidad;
  int serial; //1=liquidos 2=peso 3=cantidad


  Ingrediente(this.nombre);



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