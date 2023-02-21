// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:juegoflutter/ranking.dart';
import 'package:path_provider/path_provider.dart';

import 'Final.dart';
import 'Inicio.dart';
import 'dart:convert';
import 'dart:io';

// Color del player por turnos, para marcarlo.
List<Color> turnos = [Colors.white, Colors.amber];

// El turno para controlar a quien le toca.
int turno = 0;

//Matriz para controlar el tablero.
List<List<Color>> matrix = <List<Color>>[];

// Si el juego está acabado/ganado.
bool ganado = false;

// Para intercambiar entre vacio y lleno por el mensaje final.
String playerGanador = '';

void main() {
  crearMatrizVacia();
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: juegov2(),
  ));
}

class juegov2 extends StatefulWidget {
  const juegov2({super.key});

  @override
  State<juegov2> createState() => _juegov2State();
}

class _juegov2State extends State<juegov2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.blueGrey,
          child: Column(children: [
            Container(
              height: 75,
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 25),
                textStyle:
                    const TextStyle(fontSize: 40, fontFamily: 'EleganTech'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Inicio()),
                );
              },
              child: const Text('Inicio'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.pink,
                padding: const EdgeInsets.only(left: 55, right: 55, bottom: 25),
                textStyle: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'EleganTech',
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
              child: const Text('Juego'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 25),
                textStyle:
                    const TextStyle(fontSize: 40, fontFamily: 'EleganTech'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Final()),
                );
              },
              child: const Text('Final'),
            ),
            Image.asset('images/loto.png'),
          ]),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.pink,
          title: const Center(
            child: Text(
              'Juego 4 en línea',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Player 1',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30,
                    fontFamily: 'EleganTech',
                    fontWeight: FontWeight.bold,
                    backgroundColor: turnos[1]),
              ),
              Text('Player 2',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                      fontFamily: 'EleganTech',
                      fontWeight: FontWeight.bold,
                      backgroundColor: turnos[0])),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  height: 400,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton(context, 0),
                      buildButton(context, 1),
                      buildButton(context, 2),
                      buildButton(context, 3),
                      buildButton(context, 4),
                      buildButton(context, 5),
                    ],
                  ))
            ],
          ),
          SizedBox(
              height: 30,
              child: Text(playerGanador,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                ),
                onPressed: () {
                  reinicio();
                  setState(() {});
                },
                child: Image.asset("images/reloa.png"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                ),
                onPressed: () {},
                child: Image.asset("images/home.png"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                ),
                onPressed: () {
                  leer();setState(() {});
                  // espera un segundo para que le de tiempo a leer el archivo
                  Future.delayed(const Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ranking()),
                  );
                  });

                },
                child: Image.asset("images/copa.png"),
              ),
            ],
          ),
          // Botones de abajo juego y copa(clasificación)
        ]));
  }

  /// Va insertando desde abajo en la columna proporcionada según el turno
  /// una ficha de color (o rellena el container de dicho color)
  void cambiaColor(int columna) {
    if (!ganado) {
      for (var j = 5; j > -1; j--) {
        if (matrix[j][columna] == Colors.white) {
          turno++;
          if (turno % 2 == 0) {
            turnos[1] = Colors.amber;
            turnos[0] = Colors.white;
            matrix[j][columna] = Colors.red;
          } else {
            turnos[0] = Colors.amber;
            turnos[1] = Colors.white;
            matrix[j][columna] = Colors.blueAccent;
          }
          break;
        }
      }
      ganador();
      if (ganado) {
        turnos[1] = Colors.white;
        turnos[0] = Colors.white;
        turnos[turno % 2] = Colors.amber;
        int jugador = turno % 2;
        if (jugador == 0) {
          jugador = 2;
        }
        playerGanador = 'Ganador Player $jugador';
        almacenar(jugador);
      }
    }
    setState(() {});
  }

  /// Widget que representa cada columna.
  Widget buildButton(BuildContext context, int columna) {
    return MaterialButton(
      padding: const EdgeInsets.all(0.5),
      minWidth: 66,
      height: 390,
      onPressed: () {
        cambiaColor(columna);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(width: 60, height: 60, color: matrix[0][columna]),
          Container(width: 60, height: 60, color: matrix[1][columna]),
          Container(width: 60, height: 60, color: matrix[2][columna]),
          Container(width: 60, height: 60, color: matrix[3][columna]),
          Container(width: 60, height: 60, color: matrix[4][columna]),
          Container(width: 60, height: 60, color: matrix[5][columna]),
        ],
      ),
    );
  }
}

/// Inicia la matriz
void crearMatrizVacia() {
  if (matrix.isEmpty) {
    for (var i = 0; i < 6; i++) {
      List<Color> list = <Color>[];
      for (var j = 0; j < 6; j++) {
        list.add(Colors.white);
      }
      matrix.add(list);
    }
  }
}

/// Sirve para reiniciar todos los valores y volver a empezar la partida
void reinicio() {
  turno = 0;
  turnos[1] = Colors.amber;
  turnos[0] = Colors.white;
  ganado = false;
  playerGanador = '';
  for (var i = 0; i < 6; i++) {
    for (var j = 0; j < 6; j++) {
      matrix[i][j] = Colors.white;
    }
  }
}

/// Comprueba que hay 4 seguidos del mismo color
/// y se llama cada vez que se da click en una columna.
/// Se recorre tanto en diagonal como en horizontal y vertical.
void ganador() {
  for (int i = 0; i < 6; i++) {
    for (int j = 0; j < 3; j++) {
      if (matrix[i][j] != Colors.white &&
          matrix[i][j] == matrix[i][j + 1] &&
          matrix[i][j] == matrix[i][j + 2] &&
          matrix[i][j] == matrix[i][j + 3]) {
        ganado = true;
      }
    }
  }

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 6; j++) {
      if (matrix[i][j] != Colors.white &&
          matrix[i][j] == matrix[i + 1][j] &&
          matrix[i][j] == matrix[i + 2][j] &&
          matrix[i][j] == matrix[i + 3][j]) {
        ganado = true;
      }
    }
  }

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (matrix[i][j] != Colors.white &&
          matrix[i][j] == matrix[i + 1][j + 1] &&
          matrix[i][j] == matrix[i + 2][j + 2] &&
          matrix[i][j] == matrix[i + 3][j + 3]) {
        ganado = true;
      }
    }
  }

  for (int i = 0; i < 3; i++) {
    for (int j = 3; j < 6; j++) {
      if (matrix[i][j] != Colors.white &&
          matrix[i][j] == matrix[i + 1][j - 1] &&
          matrix[i][j] == matrix[i + 2][j - 2] &&
          matrix[i][j] == matrix[i + 3][j - 3]) {
        ganado = true;
      }
    }
  }
}

/// json que solo funciona si lo hago en un main vacio.
void almacenar(int p) async {
  Map<String, dynamic> newGanador = {
    'player': 'Player $p',
    'date': DateTime.now().toIso8601String(),
  };

  final directory = await getApplicationDocumentsDirectory();
  File file = File('${directory.path}/ganadores.json');
  if (!file.existsSync()) {
    file.createSync();
    file.writeAsStringSync(json.encode({
      'ganadores': [newGanador]
    }));
  } else {
    String jsonString = file.readAsStringSync();
    Map<String, dynamic> data = json.decode(jsonString);

    // Inicializar la lista de ganadores si no existe

    data['ganadores'].add(newGanador);

    String newJsonString = json.encode(data);
    file.writeAsStringSync(newJsonString);
  }
}
