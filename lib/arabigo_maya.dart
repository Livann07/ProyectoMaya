import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MayaConversion extends StatefulWidget {
  MayaConversion({Key key}) : super(key: key);

  @override
  _MayaConversionState createState() => _MayaConversionState();
}

class _MayaConversionState extends State<MayaConversion> {
  // * VALORES A UTILIZAR
  String valorBueno = "Correcto, ingresaste el numero equivalente en Maya";
  String valorMalo = "Error, ingresaste un número no equivalente en Maya";
  String valorComparacion = '**No has comprobado tu resultado**';

  List<String> unosPrimero = [];
  List<String> unosSegundo = [];
  List<String> unosTercero = [];
  List<String> cincoPrimero = [];
  List<String> cincoSegundo = [];
  List<String> cincoTercero = [];

  bool primerCero = false;
  bool segundoCero = false;
  bool tercerCero = false;

  int numero = Random().nextInt(401);

  // * METODO DE VERIFICACION
  verSiEsCorrectoElNumero() {
    int suma = unosSegundo.length + (cincoSegundo.length * 5);
    // SI NUMWEO ES MENOR A 20 * Primer Nivel *
    if (numero < 20) {
      valorComparacion = (suma == numero) ? valorBueno : valorMalo;
    } else {
      // SI NUMERO ES MENOR A 400 * Segundo Nivel*
      int sumaAbajo = suma;
      int sumaArriba = ((unosPrimero.length) + cincoPrimero.length * 5) * 20;
      if (numero < 400) {
        int sumaT = sumaAbajo + sumaArriba;
        if (sumaT == numero) {
          if ((sumaT % 20) == 0) {
            valorComparacion = segundoCero ? valorBueno : valorMalo;
          } else {
            valorComparacion = valorBueno;
          }
        } else {
          valorComparacion = valorMalo;
        }
      } else {
        // SI NUMERO ES DIFERENTE DE 400 * Tercer Nivel *
        int sumaUltimo = (unosTercero.length + (cincoTercero.length * 5)) * 400;
        int sumaTotal = sumaAbajo + sumaArriba + sumaUltimo;
        if (sumaTotal == numero) {
          valorComparacion = verificarCerosDe400(segundoCero, primerCero)
              ? valorBueno
              : valorMalo;
        } else {
          valorComparacion = valorMalo;
        }
      }
    }
  }

  // * METODO UNICAMENTE DE 400
  verificarCerosDe400(bool secondZero, bool firstZero) =>
      (firstZero && secondZero) ? true : false;

  // * REINICIAR VALORES CUANDO SE GENERA NUMERO
  reiniciarValoreS() {
    valorComparacion = '**No has comprobado tu resultado**';
    tercerCero = false;
    primerCero = false;
    segundoCero = false;
    unosTercero.clear();
    unosPrimero.clear();
    unosSegundo.clear();
    cincoTercero.clear();
    cincoPrimero.clear();
    cincoSegundo.clear();
    numero = Random().nextInt(401);
  }

  //* METODOS DRAG TARGET Y DRAGGABLE
  Container separadorNiveles() {
    return Container(
      height: 5,
      color: Colors.brown[700],
    );
  }

  Container primerNivel() {
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        top: 300,
        right: 50,
      ),
      width: 250,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.brown[100],
        border: Border.all(color: Colors.brown[900],width: 5),
      ),
      child: DragTarget<String>(
        builder: (context, aceptado, rechazado) {
          return Column(
            children: [
              Expanded(
                child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int x = 0; x < unosSegundo.length; x++)
                            Image.asset('assets/images/uno.png', scale: 5),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              for (int x = 0; x < cincoSegundo.length; x++)
                                Image.asset('assets/images/cinco.png',
                                    scale: 3.7),
                            ],
                          ),
                        ],
                      ),
                      if (segundoCero)
                        Image.asset('assets/images/cero.png', scale: 10),
                    ],
                  ),
                  mouseCursor: MouseCursor.uncontrolled,
                  onDoubleTap: () {
                    setState(() {
                      unosSegundo.clear();
                      cincoSegundo.clear();
                      segundoCero = false;
                      valorComparacion = '**No has comprobado tu resultado**';
                    });
                  },
                ),
              ),
            ],
          );
        },
        onAccept: (data) {
          setState(() {
            if (data == "cero") {
              segundoCero = true;
              unosSegundo.clear();
              cincoSegundo.clear();
            }
            if (data == "uno") {
              if (segundoCero) {
                segundoCero = false;
              }
              if (unosSegundo.length < 4) {
                unosSegundo.add("uno");
              }
            }
            if (data == "cinco") {
              if (segundoCero) {
                segundoCero = false;
              }
              if (cincoSegundo.length < 3) {
                cincoSegundo.add("cinco");
              }
            }
          });
        },
      ),
    );
  }

  Container segundoNivel() {
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        top: 300,
        right: 50,
      ),
      width: 250,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.brown[100],
        border: Border.all(color: Colors.brown[900], width: 5),
      ),
      child: Column(
        children: [
          //* PRIMER NIVEL
          Expanded(
              child: DragTarget<String>(
            builder: (context, aceptado, rechazado) {
              return InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int x = 0; x < unosPrimero.length; x++)
                          Image.asset('assets/images/uno.png', scale: 5),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            for (int x = 0; x < cincoPrimero.length; x++)
                              Image.asset('assets/images/cinco.png',
                                  scale: 3.7),
                          ],
                        )
                      ],
                    ),
                    if (primerCero)
                      Image.asset('assets/images/cero.png', scale: 10),
                  ],
                ),
                hoverColor: Colors.transparent,
                mouseCursor: MouseCursor.uncontrolled,
                onDoubleTap: () {
                  setState(() {
                    unosPrimero.clear();
                    cincoPrimero.clear();
                    primerCero = false;
                    valorComparacion = '**No has comprobado tu resultado**';
                  });
                },
              );
            },
            onAccept: (data) {
              setState(() {
                if (data == "cero") {
                  primerCero = true;
                  unosPrimero.clear();
                  cincoPrimero.clear();
                }
                if (data == "uno") {
                  if (primerCero) {
                    primerCero = false;
                  }
                  if (unosPrimero.length < 4) {
                    unosPrimero.add("uno");
                  }
                }
                if (data == "cinco") {
                  if (primerCero) {
                    primerCero = false;
                  }
                  if (cincoPrimero.length < 3) {
                    cincoPrimero.add("uno");
                  }
                }
              });
            },
          )),
          separadorNiveles(),
          // * SEGUNDO NIVEL
          Expanded(
            child: DragTarget<String>(
              builder: (context, aceptado, rechazado) {
                return InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int x = 0; x < unosSegundo.length; x++)
                            Image.asset(
                              'assets/images/uno.png',
                              scale: 5,
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              for (int x = 0; x < cincoSegundo.length; x++)
                                Image.asset('assets/images/cinco.png',
                                    scale: 3.7),
                            ],
                          ),
                        ],
                      ),
                      if (segundoCero)
                        Image.asset(
                          'assets/images/cero.png',
                          scale: 10,
                        ),
                    ],
                  ),
                  hoverColor: Colors.transparent,
                  mouseCursor: MouseCursor.uncontrolled,
                  onDoubleTap: () {
                    setState(() {
                      unosSegundo.clear();
                      cincoSegundo.clear();
                      segundoCero = false;
                      valorComparacion = '**No has comprobado tu resultado**';
                    });
                  },
                );
              },
              onAccept: (data) {
                setState(() {
                  if (data == "cero") {
                    segundoCero = true;
                    unosSegundo.clear();
                    cincoSegundo.clear();
                  }
                  if (data == "uno") {
                    if (segundoCero) {
                      segundoCero = false;
                    }
                    if (unosSegundo.length < 4) {
                      unosSegundo.add("uno");
                    }
                  }
                  if (data == "cinco") {
                    if (segundoCero) {
                      segundoCero = false;
                    }
                    if (cincoSegundo.length < 3) {
                      cincoSegundo.add("cinco");
                    }
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Container tercerNivel() {
    return Container(
      margin: EdgeInsets.only(
        right: 50,
        top: 100,
      ),
      width: 250,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.brown[900], width: 5),
      ),
      child: Column(
        children: [
          //* PRIMER NIVEL
          Expanded(
              child: DragTarget<String>(
            builder: (context, aceptado, rechazado) {
              return InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int x = 0; x < unosTercero.length; x++)
                          Image.asset(
                            'assets/images/uno.png',
                            scale: 6,
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            for (int x = 0; x < cincoTercero.length; x++)
                              Image.asset('assets/images/cinco.png',
                                  scale: 4.7),
                          ],
                        ),
                      ],
                    ),
                    if (tercerCero)
                      Image.asset(
                        'assets/images/cero.png',
                        scale: 10,
                      ),
                  ],
                ),
                hoverColor: Colors.transparent,
                mouseCursor: MouseCursor.uncontrolled,
                onDoubleTap: () {
                  setState(() {
                    unosTercero.clear();
                    cincoTercero.clear();
                    tercerCero = false;
                    valorComparacion = '**No has comprobado tu resultado**';
                  });
                },
              );
            },
            onAccept: (data) {
              setState(() {
                if (data == "cero") {
                  tercerCero = true;
                  unosTercero.clear();
                  cincoTercero.clear();
                }
                if (data == "uno") {
                  if (tercerCero) {
                    tercerCero = false;
                  }
                  if (unosTercero.length < 4) {
                    unosTercero.add("uno");
                  }
                }
                if (data == "cinco") {
                  if (tercerCero) {
                    tercerCero = false;
                  }
                  if (cincoTercero.length < 3) {
                    cincoTercero.add("uno");
                  }
                }
              });
            },
          )),
          separadorNiveles(),
          // * SEGUNDO NIVEL
          Expanded(
              child: DragTarget<String>(
            builder: (context, aceptado, rechazado) {
              return InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int x = 0; x < unosPrimero.length; x++)
                          Image.asset('assets/images/uno.png', scale: 6),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            for (int x = 0; x < cincoPrimero.length; x++)
                              Image.asset('assets/images/cinco.png',
                                  scale: 4.7),
                          ],
                        )
                      ],
                    ),
                    if (primerCero)
                      Image.asset('assets/images/cero.png', scale: 10),
                  ],
                ),
                hoverColor: Colors.transparent,
                mouseCursor: MouseCursor.uncontrolled,
                onDoubleTap: () {
                  setState(() {
                    unosPrimero.clear();
                    cincoPrimero.clear();
                    primerCero = false;
                    valorComparacion = '**No has comprobado tu resultado**';
                  });
                },
              );
            },
            onAccept: (data) {
              setState(() {
                if (data == "cero") {
                  primerCero = true;
                  unosPrimero.clear();
                  cincoPrimero.clear();
                }
                if (data == "uno") {
                  if (primerCero) {
                    primerCero = false;
                  }
                  if (unosPrimero.length < 4) {
                    unosPrimero.add("uno");
                  }
                }
                if (data == "cinco") {
                  if (primerCero) {
                    primerCero = false;
                  }
                  if (cincoPrimero.length < 3) {
                    cincoPrimero.add("uno");
                  }
                }
              });
            },
          )),
          separadorNiveles(),
          // * TERCER NIVEL
          Expanded(
            child: DragTarget<String>(
              builder: (context, aceptado, rechazado) {
                return InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int x = 0; x < unosSegundo.length; x++)
                            Image.asset(
                              'assets/images/uno.png',
                              scale: 6,
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              for (int x = 0; x < cincoSegundo.length; x++)
                                Image.asset(
                                  'assets/images/cinco.png',
                                  scale: 4.7,
                                ),
                            ],
                          )
                        ],
                      ),
                      if (segundoCero)
                        Image.asset(
                          'assets/images/cero.png',
                          scale: 10,
                        ),
                    ],
                  ),
                  hoverColor: Colors.transparent,
                  mouseCursor: MouseCursor.uncontrolled,
                  onDoubleTap: () {
                    setState(() {
                      unosSegundo.clear();
                      cincoSegundo.clear();
                      segundoCero = false;
                      valorComparacion = '**No has comprobado tu resultado**';
                    });
                  },
                );
              },
              onAccept: (data) {
                setState(() {
                  if (data == "cero") {
                    segundoCero = true;
                    unosSegundo.clear();
                    cincoSegundo.clear();
                  }
                  if (data == "uno") {
                    if (segundoCero) {
                      segundoCero = false;
                    }
                    if (unosSegundo.length < 4) {
                      unosSegundo.add("uno");
                    }
                  }
                  if (data == "cinco") {
                    if (segundoCero) {
                      segundoCero = false;
                    }
                    if (cincoSegundo.length < 3) {
                      cincoSegundo.add("cinco");
                    }
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Draggable<String> numerosMaya(String imagen, String numero){
    if(numero == 'cero'){
      return Draggable<String>(
        data: numero,
        child: Image.asset(
          imagen,
           scale: 10,
        ),
        feedback: Image.asset(
          imagen,
           scale: 10,
        ),
      );
    }else{
      return Draggable<String>(
        data: numero,
        child: Image.asset(
          imagen,
          scale: 5.5,
        ),
        feedback: Image.asset(
           imagen,
           scale: 5.5,
        ),
      );
    }
    
  }
  // * WIDGET
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
                'Practicar Arábigo a Maya',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // ! Numero  y números mayas
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 270, left: 60),
                      child: Text(
                        'Número: $numero',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      constraints:
                          BoxConstraints(minHeight: 120, minWidth: 120),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
                //! Dibujos de numeros y su draggable
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 300, left: 15, right: 50),
                      constraints: BoxConstraints(
                        maxWidth: 250,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.brown[100],
                          border: Border.all(color: Colors.brown[900])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: numerosMaya('assets/images/cero.png', 'cero'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child:  numerosMaya('assets/images/uno.png','uno'),
                          ),
                          numerosMaya('assets/images/cinco.png', 'cinco'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ! Texto Explicativo
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 600,
              ),
              margin: EdgeInsets.only(left: 30, bottom: 100),
              child: Text(
                'Del recuadro de arriba, toma los numeros mayas necesarios para formar el número que se te pide',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // ! Crear numero y verificación
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        if (numero < 20) primerNivel(),
                        // * REPETIR PROCESO DOS VECES
                        if (numero> 20 && numero <400) segundoNivel(),
                        // * REPETIR PROCESO 3 VECES
                        if (numero == 400)  tercerNivel(),
                      ],
                    ),
                  ],
                ),
                //! Mostrar si es correcto y botones
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 300),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: 250,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 3),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      valorComparacion,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // ! BOTONES
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            height: 50,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  verSiEsCorrectoElNumero();
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20),
                                side: BorderSide(color: Colors.black),
                              ),
                              color: Colors.brown[100],
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
                                borderRadius: new BorderRadius.circular(20),
                                side: BorderSide(color: Colors.black),
                              ),
                              color: Colors.brown[100],
                              onPressed: () {
                                setState(() {
                                  reiniciarValoreS();
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
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
