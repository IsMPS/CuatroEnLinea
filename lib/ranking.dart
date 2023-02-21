// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'Final.dart';
import 'Inicio.dart';
import 'dart:convert';
import 'dart:io';

import 'juegov2.dart';

List<String> ganadores = [];

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: ranking(),
  ));
}

class ranking extends StatefulWidget {
  const ranking({Key? key}) : super(key: key);

  @override
  State<ranking> createState() => _rankingState();
}

class _rankingState extends State<ranking> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
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
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 25),
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
              'Ganadores',
              style: TextStyle(
                color: Colors.pink,
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Container(
            color: Colors.black87,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 500,
                    width: 420,
                    child: ListView.builder(
                      itemCount: ganadores.length,
                      itemBuilder: (context, index) {
                        return buildListItem(ganadores[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Final()),
                          );},
                        child: Image.asset("images/reloa.png"),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const juegov2()),
                          );
                          crearMatrizVacia();setState(() {});
                        },
                        child: Image.asset("images/home.png"),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                        ),
                        onPressed: () {
                          setState(() {});
                        },
                        child: Image.asset("images/copa.png"),
                      ),
                    ],
                  ),
                  // Botones de abajo juego y copa(clasificación)
                ])));
  }

 Container buildListItem(String frase) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Text(
        frase,
        style: const TextStyle(
          color: Colors.pinkAccent,
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}



void leer() async {
  ganadores = [];
  final directory = await getApplicationDocumentsDirectory();
  File file = File('${directory.path}/ganadores.json');
  String contenido = file.readAsStringSync();
  Map<String, dynamic> data = await json.decode(contenido);
  List<dynamic> ganadoresList = List<dynamic>.from(data.values.first);
  for (var object in ganadoresList) {
    String name = object['player'];
    String date = object['date'];
    ganadores.add('$name\n${date.replaceAll('T', ' ')}');
  }
}
