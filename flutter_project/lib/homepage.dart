import 'package:flutter/material.dart';
import 'package:flutter_project/gradientappbar.dart';
import 'package:flutter_project/detailpage.dart';
import 'package:flutter_project/barraca.dart';
import 'dart:async';
import 'package:flutter_project/style.dart';

class HomePage extends StatelessWidget {
  final Future<List<Barraca>> barracas;

  HomePage({Key? key, required this.barracas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hora do Rango PUC-Rio')),
        body: Container(
            color: const Color(0xFF736AB7),
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
                          print('\n\nTEM DATA $snapshot.data');
                          return BarracaListWidget(barracas: snapshot.data);
                        } else if (snapshot.hasError) {
                          print('\n\nTEM ERRO $snapshot.data');
                          return Text("${snapshot.error}");
                        } else {
                          print('\n\nTEM NADA $snapshot.data');
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
            margin: EdgeInsets.all(20),
            height: 100,
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DetailPage.routeName,
                    arguments: barracas![index]);
              },
              child: Card(
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      )),
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                          child: Text(barracas![index].nomeBarraca,
                              style: Style.headerTextStyle)))),
            ),
          );
        });
  }
}
