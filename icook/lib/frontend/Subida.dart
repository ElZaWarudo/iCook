import 'dart:io';
import 'package:icook/backend/Patrones/Singleton.dart';
import 'package:icook/backend/providers/link_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:icook/backend/Ingrediente.dart';
import 'package:icook/backend/Receta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class Subida extends StatefulWidget {
  @override
  _SubidaState createState() => _SubidaState();
}

class _SubidaState extends State<Subida> {
  final int color = 0xffA60000;
  final databaseReference = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String _nombre = '',
      _tipo = '',
      _tiempo = '',
      _ingredientes = '',
      _descripcion = '',
      _calorias = '',
      _cantidad = '',
      _serial = '',
      _link = '';

  void CrearReceta() {
    List<Ingrediente> Ingredientes = new List();
    List nombreIng = ListaIng(_ingredientes);
    List num = Listanum(_cantidad);
    List serial = Listanum(_serial);
    for (int i = 0; i <= nombreIng.length - 1; i++) {
      Ingrediente ingrediente =
          new Ingrediente(nombreIng[i], num[i], serial[i]);
      Ingredientes.add(ingrediente);
    }
    Receta receta = new Receta(_nombre, _descripcion, int.parse(_calorias),
        int.parse(_tiempo), _tipo, DateTime.now(), Ingredientes, _link);
    //Creacion del patron singleton para que sea una unica receta
    Singleton RecetaUnica= Singleton.getSingleton(receta);
    receta=null;//Limpieza de la receta
    recordReceta(RecetaUnica.receta, nombreIng, num, serial);
  }

  ListaIng(String x) {
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

  Listanum(String x) {
    List<int> ArrayIngredientes = new List();
    x += ",";
    String palabrita = "";
    for (var i = 0; i <= x.length - 1; i++) {
      if (x[i] != ',') {
        palabrita += x[i];
      } else {
        ArrayIngredientes.add(int.parse(palabrita));
        palabrita = "";
      }
    }
    return ArrayIngredientes;
  }

  void recordReceta(Receta x, List ing, List cant, List serial) async {
    await databaseReference.collection("Recetas").document().setData({
      'Calorias': x.calorias,
      'Cantidad': cant,
      'Descripcion': x.descripcion,
      'Hora': x.hora,
      'IngredienteName': ing,
      'Link': x.link,
      'Nombre': x.nombre,
      'Serial': serial,
      'TiempoPreparacion': x.tiempoPreparacion,
      'Tipo': x.tipo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        FormularioReceta(context),
      ],
    ));
  }

  Widget FormularioReceta(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 182.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 0.0),
            padding: EdgeInsets.symmetric(vertical: 40.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('INGRESE DATOS', style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 40.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.font_download,
                          color: Color(color),
                        ),
                        hintText: 'Nombre ',
                        labelText: 'Nombre de Receta',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _nombre = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.font_download,
                          color: Color(color),
                        ),
                        hintText: 'Tipo ',
                        labelText: 'Escribir tipo',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _tipo = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.font_download,
                          color: Color(color),
                        ),
                        hintText: 'Tiempo de la Receta ',
                        labelText: 'Escribir Tiempo',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _tiempo = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.font_download,
                          color: Color(color),
                        ),
                        hintText: 'Ingrediente1,Ingrediente2 ',
                        labelText: 'Escribir Ingredientes',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _ingredientes = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.font_download,
                          color: Color(color),
                        ),
                        hintText: 'Cantidad1,Cantidad2 ',
                        labelText: 'Escribir Cantidad',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _cantidad = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.font_download,
                          color: Color(color),
                        ),
                        hintText: 'Serial1,Serial2 ',
                        labelText: 'Escribir Serial',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _serial = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.font_download,
                          color: Color(color),
                        ),
                        hintText: 'Calorias de la receta ',
                        labelText: 'Escribir calorias',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _calorias = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.font_download,
                          color: Color(color),
                        ),
                        hintText: 'Pasos de Receta ',
                        labelText: 'Escribir Pasos',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _descripcion = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SubirFoto(),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60.0, vertical: 15.0),
                      child: Text('CREAR RECETA'),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 0.0,
                    color: Color(color),
                    textColor: Colors.white,
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      _link = Provider.of<linkString>(context).link_p;
                      CrearReceta();
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearIngrePrinc() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.font_download,
            color: Color(color),
          ),
          hintText: 'Ingrediente Principal ',
          labelText: 'Esccribir Ingrediente',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Campo obligatorio';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoRojo = Container(
      height: size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(166, 0, 0, 1.0),
            Color.fromRGBO(166, 0, 0, 1.0)
          ],
        ),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.3)),
    );

    return Stack(
      children: <Widget>[
        fondoRojo,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.content_paste, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('CREAR RECETA',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}

class SubirFoto extends StatefulWidget {
  @override
  _SubirFotoState createState() => _SubirFotoState();
}

class _SubirFotoState extends State<SubirFoto> {
  File _image;
  String _link;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          obtenerImagen(context);
        },
        child: new Container(
            alignment: Alignment.center,
            height: 40.0,
            width: 200,
            decoration: new BoxDecoration(
                color: new Color(0xffA60000),
                borderRadius: new BorderRadius.circular(5.0)),
            child: new Text("Subir foto",
                style: new TextStyle(fontSize: 15.0, color: Colors.white))),
      ),
    );
  }

  Future obtenerImagen(BuildContext context) async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
    subirImagen(context);
  }

  Future subirImagen(BuildContext context) async {
    String nombreFoto = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(nombreFoto);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then((fileURL) {
      setState(() {
        _link = fileURL;
        Provider.of<linkString>(context).link_p = _link;
      });
    });
  }
}
