import 'package:flutter/material.dart';
import 'package:flutter_project/gradientappbar.dart';
import 'package:flutter_project/detailpage.dart';
import 'package:flutter_project/barraca.dart';
import 'dart:async';
import 'package:flutter_project/style.dart';
import 'package:flutter_project/palette.dart';

class HomePage extends StatelessWidget {
  final Future<List<Barraca>> barracas;

  HomePage({Key? key, required this.barracas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hora do Rango PUC-Rio')),
        body: Container(
            color: const Color.fromARGB(218, 160, 209, 219),
            child: Center(
                child: Column(children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: FutureBuilder<List<Barraca>>(
                      future: barracas,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return BarracaListWidget(barracas: snapshot.data);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return const CircularProgressIndicator();
                        }
                      })),
            ]))));
  }
}

class BarracaListWidget extends StatelessWidget {
  final List<Barraca>? barracas;

  const BarracaListWidget({Key? key, required this.barracas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: barracas?.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(20),
            height: 100,
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DetailPage.routeName,
                    arguments: barracas![index]);
              },
              child: Card(
                  color: createMaterialColor(
                      const Color.fromARGB(222, 250, 250, 250)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      )),
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(children: [
                        Container(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: const Align(
                                alignment: Alignment.topRight,
                                child: Estrela())),
                        Center(
                            child: Text(barracas![index].nomeBarraca,
                                style: Style.headerTextStyle))
                      ]))),
            ),
          );
        });
  }
}

class Estrela extends StatefulWidget {
  const Estrela({Key? key}) : super(key: key);

  @override
  _EstrelaState createState() => _EstrelaState();
}

class _EstrelaState extends State<Estrela> {
  bool _isFavorited = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _toggleFavorite,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        alignment: Alignment.centerRight,
        icon: (_isFavorited
            ? const Icon(Icons.thumb_up,
                color: Color.fromARGB(218, 153, 219, 232))
            : const Icon(Icons.thumb_up_off_alt,
                color: Color.fromARGB(218, 153, 219, 232))),
        onPressed: () {},
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }
}
