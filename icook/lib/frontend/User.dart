import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:icook/Login/login_state.dart';
import 'package:icook/frontend/Subida.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  File _image;
  @override
  Widget build(BuildContext context) {

    Future obtenerImagen() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image=image;
        print('Path $_image');
      });
    }

    Future subirImagen(BuildContext context) async{
      String nombreFoto = basename(_image.path);
      StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child(nombreFoto);
      StorageUploadTask uploadTask=firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Foto actualizada correctamente')));
      });
    }

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new CircleAvatar(
                      radius: 70,
                      backgroundColor: Color(0xffA60000),
                      child: ClipOval(
                        child: SizedBox(
                          width: 130,
                          height: 130,
                          child: Image.network(
                            "https://ep01.epimg.net/elpais/imagenes/2016/05/04/tentaciones/1462381330_389964_1487673046_noticia_normal.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.camera,
                          size: 30,
                        ),
                        onPressed: () {
                          obtenerImagen();
                          subirImagen(context);
                        },
                      ),
                    )
                  ],
                ),
                new SizedBox(
                  height: 7.0,
                ),
                new Text("Elen Pagina", style: new TextStyle(fontSize: 20.0)),
                new SizedBox(
                  height: 13.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Crear receta",
                        style: new TextStyle(fontSize: 20.0)),
                    new SizedBox(
                      width: 15.0,
                    ),
                    new RaisedButton(
                      elevation: 0.0,
                      animationDuration: Duration(seconds: 0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Subida(),
                          ),
                        );
                      },
                      child: Text(""),
                    ),
                  ],
                ),
                new SizedBox(
                  height: 7.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Loggout", style: new TextStyle(fontSize: 20.0)),
                    new SizedBox(
                      width: 15.0,
                    ),
                    new RaisedButton(
                      elevation: 0.0,
                      animationDuration: Duration(seconds: 0),
                      onPressed: () {
                        Provider.of<LoginState>(context).logout();
                      },
                      child: Text(""),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
