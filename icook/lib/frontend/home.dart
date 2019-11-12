import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icook/frontend/User.dart';
import 'package:icook/backend/providers/ingredientes_provider.dart';
import 'package:icook/frontend/ver_consulta.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  final List<Widget> _children = [
    MainContent(),
    User(),
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_bottomNavIndex],
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0xffA60000),
        currentIndex: _bottomNavIndex,
        onTap: (int index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        items: [
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(FontAwesomeIcons.book)),
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(FontAwesomeIcons.solidUserCircle))
        ],
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  TextEditingController controlador = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ingredienteString = Provider.of<IngredientesString>(context);
    return new ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: new Container(
              child: new Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  new Text(
                    "Busqueda por ingrediente",
                    style: new TextStyle(
                      fontSize: 26.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              new SizedBox(
                height: 10.0,
              ),
              new Row(
                children: <Widget>[
                  Container(
                    width: 250,
                    child: TextField(
                      controller: controlador,
                      decoration: InputDecoration(
                        icon: new Icon(FontAwesomeIcons.search),
                      ),
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: new RaisedButton(
                      onPressed: () {
                        ingredienteString.Ingredientes_p=controlador.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerConsulta(),
                          ),
                        );
                      },
                      child: new Text(
                        "Buscar",
                        style: new TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
              new SizedBox(
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text("Popular Trending",
                          style: new TextStyle(fontSize: 18.0))),
                  new Expanded(
                      child: new Text(
                    "View All",
                    style: new TextStyle(color: Color(0xffA60000)),
                    textAlign: TextAlign.end,
                  ))
                ],
              ),
              new SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  new Expanded(
                    child: Container(
                      height: 150.0,
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            height: 100.0,
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new NetworkImage(
                                        'https://cocina-casera.com/mx/wp-content/uploads/2018/01/tacoas-de-carne-enchilada.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                          new Text(
                            "Mexicana",
                            style: new TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                  new SizedBox(
                    width: 5.0,
                  ),
                  new Expanded(
                    child: Container(
                      height: 150.0,
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            height: 100.0,
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new NetworkImage(
                                        'https://i.blogs.es/80ab49/1366_2000/450_1000.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                          new Text("Mediterranea",
                              style: new TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                  ),
                  new SizedBox(
                    width: 5.0,
                  ),
                  new Expanded(
                    child: Container(
                      height: 150.0,
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            height: 100.0,
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new NetworkImage(
                                        'https://cdn.needish.com/is-prod-deals/W30R4igXwsX15srFHUu9uQ/scale/900x600.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                          new Text('Urbana',
                              style: new TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              new SizedBox(
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text("Receta del dia",
                          style: new TextStyle(fontSize: 18.0))),
                ],
              ),
              new SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  new Expanded(
                    child: Container(
                      height: 150.0,
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            height: 100.0,
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new NetworkImage(
                                        'https://static.vix.com/es/sites/default/files/styles/4x3/public/imj/elgranchef/R/Receta-de-ensalada-Cesar-1.jpg?itok=1RBs6hiJ'),
                                    fit: BoxFit.cover)),
                          ),
                          new Text(
                            "Ensalada Shizaaaaaaaa",
                            style: new TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
        )
      ],
    );
  }
}
