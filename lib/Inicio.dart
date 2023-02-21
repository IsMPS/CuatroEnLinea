// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'Final.dart';
import 'juegov2.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: Inicio(),
  ));
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.blueGrey,
          child: Column(children: [
            Container(
              height: 40,
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.pink,
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 25),
                textStyle: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'EleganTech',
                    fontWeight: FontWeight.bold),
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
                foregroundColor: Colors.black,
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 25),
                textStyle:
                    const TextStyle(fontSize: 40, fontFamily: 'EleganTech'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const juegov2()),
                );
                crearMatrizVacia();
              },
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
          title: const Text(
              'INICIO',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        body: Container(
            height: 800,
            color: Colors.blueGrey,
            child: Column(children: [
              MaterialButton(
                  child: Image.asset('images/loto.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const juegov2()),
                    );
                    crearMatrizVacia();setState(() {});
                  }),
              const SizedBox(
                  width: 355,
                  child: Text('Bienvenido a lotus\n   Cuatro en línea',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'EleganTech',
                          fontSize: 33)))
            ])));
  }
}
