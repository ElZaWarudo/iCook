import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icook/backend/providers/ingredientes_provider.dart';
import 'package:provider/provider.dart';

class VerReceta extends StatefulWidget {
  @override
  _VerRecetaState createState() => _VerRecetaState();
}

class _VerRecetaState extends State<VerReceta> {
  @override
  Widget build(BuildContext context) {

    final ingredientesString = Provider.of<IngredientesString>(context);

    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('Recetas').where('IngredienteName', isEqualTo: Lista(ingredientesString.Ingredientes_p)).snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return Text('No encontrado', style: TextStyle(fontSize: 22),);
          return Column(
            children: <Widget>[
              Text(snapshot.data.documents[0]['Nombre'], style: TextStyle(fontSize: 16)),
              SizedBox(
                width: 50.0,
              ),
              Text("Ingredientes: "+ToStringIngredientes(snapshot.data.documents[0]['Ingredientes']), style: TextStyle(fontSize: 15),),
              Text("Descripcion: "+snapshot.data.documents[0]['Descripcion'], style: TextStyle(fontSize: 15),),
              Text("Tiempo de preparacion: "+snapshot.data.documents[0]['TiempoPreparacion'].toString()+" minutos", style: TextStyle(fontSize: 15),),
            ],
          );
        },
      ),
    );
  }

  Lista(String x){
    List<String> ArrayIngredientes = new List();
    x+=",";
    String palabrita="";
    for(var i=0;i<=x.length-1;i++){
      if(x[i]!=','){
        palabrita+=x[i];
      }else{
        ArrayIngredientes.add(palabrita);
        palabrita="";
      }
    }
    return ArrayIngredientes;
  }

  ToStringIngredientes(List<dynamic> ingredientes){
    String x="";
    for (var f in ingredientes){
      if(f!=ingredientes.length-1)x+=f+',';
    }
    return x;
  }
}
