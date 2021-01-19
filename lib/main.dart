import 'package:flutter/material.dart';
import 'package:maya_final/maya_arabigo.dart';
import 'package:maya_final/arabigo_maya.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversiones Maya - Decimal / Decimal - Maya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Principal(),
    );
  }
}

class Principal extends StatelessWidget {
  const Principal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/descarga.jpg', fit: BoxFit.cover),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Numeración Maya - Proyecto Final',
                  style: TextStyle(
                    fontSize: 58,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                botones("Arábigo - Maya", context),
                
                botones("Maya - Arábigo", context),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget botones(String texto, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      top: 50,
      bottom: 15,
    ),
    width: 300,
    height: 50,
    child: RaisedButton(
      color: Colors.orangeAccent,
      onPressed: () {
        Navigator.push(
          context,
          mpg(texto, context),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.black),
      ), 
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

MaterialPageRoute mpg(String texto, BuildContext context) {
  return MaterialPageRoute(
      builder: (context) =>
          (texto == "Arábigo - Maya") ? MayaConversion() : ArabigoConversion());
}
