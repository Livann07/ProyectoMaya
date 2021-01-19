import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArabigoConversion extends StatefulWidget {
  const ArabigoConversion({Key key}) : super(key: key);

  @override
  _ArabigoConversion createState() => _ArabigoConversion();
}

class _ArabigoConversion extends State<ArabigoConversion> {
  //* VALORES A UTILIZAR EN EL WIDGET
  List<String> nombresImagenes = [
    "cero.png",
    "uno.png",
    "dos.png",
    "tres.png",
    "cuatro.png",
    "cinco.png",
    "seis.png",
    "siete.png",
    "ocho.png",
    "nueve.png",
    "diez.png",
    "once.png",
    "doce.png",
    "trece.png",
    "catorce.png",
    "quince.png",
    "dieciseis.png",
    "diecisiete.png",
    "dieciocho.png",
    "diecinueve.png",
  ];

  String valorComparacion = '**No has comprobado tu resultado**';

  int numero = Random().nextInt(401);

  TextEditingController numeroCapturado = TextEditingController();

//* METODOS A UTILIZAR EN WIDGET
  _verSiEsCorrectoNumero() {
    if (numeroCapturado.text != "") {
      if (int.parse(numeroCapturado.text) == numero) {
        valorComparacion =
            "Correcto, ingresaste el numero equivalente en Arábigo";
      } else {
        valorComparacion =
            "Error, ingresaste un número no equivalente en Arábigo";
      }
    } else {
      valorComparacion = "Error, ingresa un número por favor";
    }
  }

  String imagenPrimerPiso() => "assets/images/" + nombresImagenes[numero];

  String imagenSegundoPiso(int piso) {
    String l ="";
    int pisoUno = numero % 20;
    int pisoDos = numero ~/ 20;
    l = (piso == 2) ? "assets/images/" + nombresImagenes[pisoDos]: "assets/images/" + nombresImagenes[pisoUno];
    return l;
  }

  String imagenTercerPiso(int piso) {
    String img = "";
    int pisoTres = numero ~/ 400;
    int pisoDos = (numero - (pisoTres * 400)) ~/ 20;
    int pisoUno = (numero - (pisoTres * 400)) % 20;

    switch (piso) {
      case 3:
        img = "assets/images/" + nombresImagenes[pisoTres];
        break;
      case 2:
        img = "assets/images/" + nombresImagenes[pisoDos];
        break;
      case 1:
        img = "assets/images/" + nombresImagenes[pisoUno];
        break;
    }
    return img;
  }

//* CREACIONES VISUALES
  Expanded expSegundoPiso(int nivel) {
    return Expanded(
      child: Center(
        child: Image.asset(
          imagenSegundoPiso(nivel),
          fit: BoxFit.fitWidth,
          scale: 5,
        ),
      ),
    );
  }

  Expanded expTercerPiso(int nivel) {
    return Expanded(
      child: Center(
        child: Image.asset(
          imagenTercerPiso(nivel),
          fit: BoxFit.fitWidth,
          scale: 5,
        ),
      ),
    );
  }

  Container separadorNiveles() {
    return Container(
      height: 5,
      color: Colors.brown[700],
    );
  }

//* WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ! Fondo de pantalla
          Positioned.fill(
            child: Image.asset('assets/images/d.jpg', fit: BoxFit.cover),
          ),
          // ! Botón para atras
          Container(
              margin: EdgeInsets.only(
                top: 100,
                left: 100,
              ),
              width: 50,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
          ),
          // ! Titulo del documento
          Container(
            margin: EdgeInsets.only(
              top: 100,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Practicar Maya a Arábigo',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // ! Es donde está el contenido real del ejercicio
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30, bottom: 15),
                      child: Text(
                        'Ingrese número',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30, top: 30, left: 30),
                      width: 170,
                      height: 50,
                      color: Colors.white,
                      child: Center(
                        child: TextField(
                          controller: numeroCapturado,
                          decoration: InputDecoration(
                            hintText: "Número arábigo",
                            counterText: "",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          style: TextStyle(
                            height: 1,
                            fontSize: 18,
                          ),
                          maxLength: 3,
                          textAlign: TextAlign.center,
                          cursorHeight: 24,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 23, right: 5),
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20),
                              side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.brown[100],
                            onPressed: () {
                              setState(() {
                                _verSiEsCorrectoNumero();
                              });
                            },
                            child: Text(
                              'Comprobar',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.brown[100],
                            onPressed: () {
                              setState(() {
                                numero = Random().nextInt(401);
                                valorComparacion =
                                    "**No has comprobado tu resultado**";
                                numeroCapturado.text = "";
                              });
                            },
                            child: Text(
                              'Nuevo Número',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.brown[700],
                          width: 3,
                        ),
                        color: Colors.white,
                      ),
                      constraints: BoxConstraints(
                        minHeight: 300,
                        minWidth: 160,
                        maxHeight: 320,
                        maxWidth: 190,
                      ),
                      child: Column(children: [
                        if (numero < 20)
                          Expanded(
                              child: Center(
                            child: Image.asset(
                              imagenPrimerPiso(),
                              fit: BoxFit.fitWidth,
                              scale: 5,
                            ),
                          )),
                        if (numero >= 20 && numero < 400)
                          Expanded(
                            child: Column(
                              children: [
                                expSegundoPiso(2),
                                separadorNiveles(),
                                expSegundoPiso(1),
                              ],
                            ),
                          ),
                        if (numero == 400)
                          Expanded(
                            child: Column(
                              children: [
                                expTercerPiso(3),
                                separadorNiveles(),
                                expTercerPiso(2),
                                separadorNiveles(),
                                expTercerPiso(1),
                              ],
                            ),
                          )
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ! Es donde dice si está bien o mal
          Container(
            margin: EdgeInsets.only(bottom: 200),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 480,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.brown[700], width: 3),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    valorComparacion,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
