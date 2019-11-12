import 'package:flutter/material.dart';
import 'package:icook/backend/Receta.dart';


class Muestriar extends StatelessWidget {
  List<Receta> Recetas;
  int index;

  Muestriar(this.Recetas,this.index);

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: '¡COOK',
      debugShowCheckedModeBanner: false,
      // Set Raleway as the default app font
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),

      home: RecipeSinglePage(Recetas, index),
    );
  }
}

class RecipeSinglePage extends StatelessWidget {

  List<Receta> Recetas;
  int index;

  RecipeSinglePage(this.Recetas,this.index);
  final Color icon = Color(0xffEF412D);
  final Color color3 = Color(0xffFFD54F);
  final Color color2 = Color(0xffFFD54F);
  final Color color1 = Color(0xffC8A415);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 350,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [color2, color3],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                      )
                  ),
                )
            ),
            Positioned(
                top: 350,
                left: 0,
                right: 150,
                bottom: 80,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: color1,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50.0)
                      )
                  ),
                )
            ),
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Text(Recetas[index].nombre.toUpperCase(), style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0
                    ),),
                    SizedBox(height: 20.0),
                    SizedBox(
                      height: 30.0,
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.whatshot, color: Colors.white),
                          SizedBox(width: 5.0),
                          Text(Recetas[index].calorias.toString()+" calorias",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                          Spacer(),
                          VerticalDivider(color: Colors.white),
                          Spacer(),
                          Text(Recetas[index].tipo,style: TextStyle(color: Colors.white, fontSize: 18.0),),
                          Spacer(),
                          VerticalDivider(color: Colors.white),
                          Spacer(),
                          Icon(Icons.query_builder, color: Colors.white),
                          SizedBox(width: 5.0),
                          Text(Recetas[index].tiempoPreparacion.toString()+" min",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Text(Recetas[index].descripcion, style: TextStyle(color: Colors.white70),),
                  ],
                ),
              ),
            ),
            Container(
              height: 380,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 30.0
                    )
                  ]
              ),
              child: SizedBox(
                height: 350,
                child: Image.network(Recetas[index].link, fit: BoxFit.cover),),
            ),
/*            Positioned(
              top: 325,
              left: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: IconButton(
                  color: icon,
                  onPressed: (){},
                  icon: Icon(Icons.play_arrow,)),
              ),
            ),*/
            Positioned(
              top: 325,
              right: 20,
              child: RaisedButton(
                child: Text("Read More".toUpperCase()),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                  ));
                },
              ),
            ),
            Container(height: 70.0, child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )),
          ],
        ),
      ),
    );
  }
}