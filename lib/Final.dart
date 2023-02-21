// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

import 'Inicio.dart';
import 'juegov2.dart';

var notaa = 'Nota: ';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: Final(),
  ));
}

class Final extends StatefulWidget {
  const Final({super.key});

  @override
  State<Final> createState() => _FinalState();
}

class _FinalState extends State<Final> {
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
                foregroundColor: Colors.black,
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 25),
                textStyle:
                    const TextStyle(fontSize: 40, fontFamily: 'EleganTech'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const juegov2()),
                );crearMatrizVacia();
                setState(() {});
              },
              child: const Text('Juego'),
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
              'FINAL',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
        ),
        body: Container(
          color: Colors.black,
          height: 900,
          width: 500,
          child: Column(children: [
            const SizedBox(height: 25),
            Container(
              width: 350,
              padding: const EdgeInsets.all(10),
              color: Colors.red,
                child: const Text('Isabel Maye Piulestan',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold))),
            const SizedBox(height: 25),
            Container(
                width: 350,
                padding: const EdgeInsets.all(10),
                color: Colors.orange,
                child: const Text('Proyecto Flutter',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold))),
            const SizedBox(height: 25),
            Container(
                width: 350,
                padding: const EdgeInsets.all(10),
                color: Colors.amber,
                child: const Text('2ºDAM',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold))),
            const SizedBox(height: 25),
            Container(
                width: 350,
                padding: const EdgeInsets.all(10),
                color: Colors.green,
                child: const Text('GAME OVER',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold))),
            const SizedBox(height: 25),
            Container(
                width: 350,
                padding: const EdgeInsets.all(10),
                color: Colors.blueAccent,
                child:  Text(notaa,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold))),
            const SizedBox(height: 25),
            Container(
                width: 350,
                padding: const EdgeInsets.all(10),
                color: Colors.deepPurple,
                child: TextButton(
                    onPressed: () {aplicarNota();setState(() {
                }); },
                child: const Text('Calificar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold))))
          ]),
        ));
  }

  void aplicarNota(){
    notaa='Nota: 10';
  }
}


