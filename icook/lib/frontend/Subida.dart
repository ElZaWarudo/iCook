import 'package:flutter/material.dart';


class Subida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
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
            child: Column(
              children: <Widget>[
                Text('INGRESE DATOS', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 40.0),
                _crearNombre(),
                SizedBox(height: 20.0),
                _crearTipo(),
                SizedBox(height: 20.0),
                _crearTiempo(),
                SizedBox(height: 20.0),
                _crearIngredientes(),
                SizedBox(height: 20.0),
                _crearIngrePrinc(),
                SizedBox(height: 20.0),
                _crearPasos(),
                SizedBox(height: 20.0),
                _crearBoton(),
                SizedBox(height: 20.0),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearNombre() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.font_download,
            color: Colors.deepOrange,
          ),
          hintText: 'Nombre ',
          labelText: 'Nombre de Receta',
        ),
      ),
    );
  }

  Widget _crearTipo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.font_download,
            color: Colors.deepOrange,
          ),
          hintText: 'Tipo ',
          labelText: 'Esccribir tipo',
        ),
      ),
    );
  }

  Widget _crearTiempo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.font_download,
            color: Colors.deepOrange,
          ),
          hintText: 'Tiempo de la Receta ',
          labelText: 'Escribir Tiempo',
        ),
      ),
    );
  }

  Widget _crearIngredientes() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.font_download,
            color: Colors.deepOrange,
          ),
          hintText: 'Ingrediente1,Ingrediente2 ',
          labelText: 'Esccribir Ingredientes',
        ),
      ),
    );
  }

  Widget _crearIngrePrinc() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.font_download,
            color: Colors.deepOrange,
          ),
          hintText: 'Ingrediente Principal ',
          labelText: 'Esccribir Ingrediente',
        ),
      ),
    );
  }

  Widget _crearPasos() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.font_download,
            color: Colors.deepOrange,
          ),
          hintText: 'Pasos de Receta ',
          labelText: 'Escribir Pasos',
        ),
      ),
    );
  }

  Widget _crearImagen() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.font_download,
            color: Colors.deepOrange,
          ),
          hintText: 'Pasos de Receta ',
          labelText: 'Escribir Pasos',
        ),
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
        child: Text('CREAR RECETA'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Colors.red,
      textColor: Colors.white,
      onPressed: () {},
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoRojo = Container(
      height: size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(255, 0, 0, 1.0),
        Color.fromRGBO(255, 0, 0, 1.0)
      ])),
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
