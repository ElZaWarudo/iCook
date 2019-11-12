import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icook/backend/Ingrediente.dart';
import 'package:icook/backend/Receta.dart';
import 'package:icook/backend/providers/ingredientes_provider.dart';
import 'package:icook/frontend/Muestracion.dart';
import 'package:provider/provider.dart';

class VerConsulta extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final ingredienteString = Provider.of<IngredientesString>(context);
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("Busqueda"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          backgroundColor: Color(0xffA60000),
          elevation: 2,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
            )
          ],
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('Recetas')
              .where("IngredienteName",
                  isEqualTo: Listax(ingredienteString.Ingredientes_p))
              .snapshots(),
          builder: (context, snapshot) {
            List<Receta> recetas = new List();
            if (!snapshot.hasData) {
              return Text('No encontrado', style: TextStyle(fontSize: 22));
            } else {
              String Nombre, Descripcion, Tipo, IngredienteName, Link;
              int TiempoPreparacion, Calorias, Cantidad, Serial;
              Timestamp Hora;
              for (int i = 0; i <= snapshot.data.documents.length - 1; i++) {
                Nombre = snapshot.data.documents[i]['Nombre'];
                Descripcion = snapshot.data.documents[i]['Descripcion'];
                Calorias = snapshot.data.documents[i]['Calorias'];
                TiempoPreparacion =
                    snapshot.data.documents[i]['TiempoPreparacion'];
                Tipo = snapshot.data.documents[i]['Tipo'];
                Hora = snapshot.data.documents[i]['Hora'];
                Link = snapshot.data.documents[i]['Link'];
                List<Ingrediente> Ingredientes = new List();
                for (int j = 0; j <= snapshot.data.documents.length - 1; j++) {
                  IngredienteName =
                      snapshot.data.documents[i]['IngredienteName'][j];
                  Cantidad = snapshot.data.documents[i]['Cantidad'][j];
                  Serial = snapshot.data.documents[i]['Serial'][j];
                  Ingrediente loquesea =
                      new Ingrediente(IngredienteName, Cantidad, Serial);
                  Ingredientes.add(loquesea);
                }
                Receta NuevaReceta = new Receta(Nombre, Descripcion, Calorias,
                    TiempoPreparacion, Tipo, Hora, Ingredientes, Link);
                recetas.add(NuevaReceta);
              }
              return Lists(recetas);
            }
          },
        ),
      ),
    );
  }

  Listax(String x) {
    List<String> ArrayIngredientes = new List();
    x += ",";
    String palabrita = "";
    for (var i = 0; i <= x.length - 1; i++) {
      if (x[i] != ',') {
        palabrita += x[i];
      } else {
        ArrayIngredientes.add(palabrita);
        palabrita = "";
      }
    }
    return ArrayIngredientes;
  }
}

class Item {
  final String nombre;
  final String tipo;
  final String calorias;
  final String tiempo;
  final String image;
  final int index;


  Item.Try(this.nombre, this.tipo, this.calorias, this.tiempo, this.image, this.index);
}

class Lists extends StatelessWidget {
  List<Receta> _recetas = new List();
  List<Item> _data = new List();

  Lists(this._recetas);

  void creacionRec() {
    for (int i =0; i< _recetas.length;i++) {
      Receta rec;

      Item Objeto = new Item.Try(_recetas[i].nombre, _recetas[i].tipo, _recetas[i].calorias.toString(),
          _recetas[i].tiempoPreparacion.toString(), "", i);
      _data.add(Objeto);
    }
  }

  @override
  Widget build(BuildContext context) {
    creacionRec();
    final size = MediaQuery.of(context).size;
    final TextStyle dropdownMenuItem =
        TextStyle(color: Colors.black, fontSize: 18);
    return ListView.builder(
      padding: EdgeInsets.all(6),
      itemCount: _data.length,
      itemBuilder: (BuildContext context, int index) {
        Item item = _data[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Muestriar(_recetas, index),
                ));
          },
          child: Card(
            elevation: 3,
            child: Row(
              children: <Widget>[
                Container(
                  height: 125,
                  width: 110,
                  padding:
                      EdgeInsets.only(left: 0, top: 10, bottom: 70, right: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: new NetworkImage(item.image), fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.nombre,
                        style: TextStyle(
                            color: Color(0xffA60000),
                            fontWeight: FontWeight.w700,
                            fontSize: 17),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Tipo:",
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            item.tipo,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Calorias:",
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            item.calorias,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Tiempo:",
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            item.tiempo+" min",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
