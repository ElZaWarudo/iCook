import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:icook/backend/providers/email_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:icook/Login/login_state.dart';
import 'package:icook/frontend/Subida.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  var docref;
  String _nombre, _link, _linkNuevo;
  File _image;
  @override
  Widget build(BuildContext context) {
    Future obtenerImagen() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Path $_image');
      });
    }

    Future subirImagen(BuildContext context) async {
      String nombreFoto = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(nombreFoto);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      firebaseStorageRef.getDownloadURL().then((fileURL) {
        setState(() {
          _linkNuevo = fileURL;
        });
      });
      Firestore.instance.collection("Usuarios")
          .document(docref)
          .updateData({'Foto': _linkNuevo});
      setState(() {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Foto actualizada correctamente')));
      });
    }

    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Usuarios')
            .where("Email", isEqualTo: Provider.of<emailString>(context).email_p)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            docref = snapshot.data.documents[0].documentID;
            _nombre = snapshot.data.documents[0]['Nombre'];
            _link = snapshot.data.documents[0]['Foto'];
            return ListView(
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
                                  _link,
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
                                Timer(Duration(seconds: 3),(){
                                  subirImagen(context);
                                });

                              },
                            ),
                          )
                        ],
                      ),
                      new SizedBox(
                        height: 7.0,
                      ),
                      new Text(_nombre,
                          style: new TextStyle(fontSize: 20.0)),
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
                          new Text("Loggout",
                              style: new TextStyle(fontSize: 20.0)),
                          new SizedBox(
                            width: 15.0,
                          ),
                          new RaisedButton(
                            elevation: 0.0,
                            animationDuration: Duration(seconds: 0),
                            onPressed: () {
                              Provider.of<LoginState>(context).logout();
                              dispose();
                            },
                            child: Text(""),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  obtenerEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('email');
  }

}
