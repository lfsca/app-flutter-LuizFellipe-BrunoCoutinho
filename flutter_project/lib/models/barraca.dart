import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/models/quentinha.dart';
import 'package:flutter_project/models/avaliacao.dart';
import 'dart:convert';

class Barraca {
  final String nomeBarraca;
  final String descricao;
  final String imagemBarraca;
  final List<Avaliacao> avaliacoes;
  final List<Quentinha> quentinhas;

  Barraca(
      {this.nomeBarraca = "a",
      this.descricao = "a",
      this.imagemBarraca = "a",
      required this.avaliacoes,
      required this.quentinhas});

  factory Barraca.fromJson(Map<String, dynamic> json) {
    List<Quentinha> listaQuentinhas = [];
    List<Avaliacao> listaAvaliacoes = [];

    for (var quentinha in json['quentinhas']) {
      listaQuentinhas.add(Quentinha.fromJson(quentinha));
    }

    for (var avaliacao in json['avaliacoes']) {
      listaAvaliacoes.add(Avaliacao.fromJson(avaliacao));
    }

    return Barraca(
        nomeBarraca: json['nomeBarraca'],
        descricao: json['descricao'],
        imagemBarraca: json['imagemBarraca'],
        avaliacoes: listaAvaliacoes,
        quentinhas: listaQuentinhas);
  }

  double calculaMediaAvaliacoes() {
    double media = 0;
    for (var avaliacao in avaliacoes) {
      media += avaliacao.nota;
    }
    media = media / avaliacoes.length;
    return media;
  }
}

// Future<List<Barraca>> fetchBarracas() async {
//   List<Barraca> list = [];
//   final String response =
//       await rootBundle.loadString('assets/json/barracas.json');
//   final decodedResponse = await json.decode(response);

//   for (var barraca in decodedResponse) {
//     list.add(Barraca.fromJson(barraca));
//   }
//   return list;
// }

Future<List<Barraca>> fetchBarracas() async {
  List<Barraca> list = [];
  await FirebaseFirestore.instance
      .collection('barraca')
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      list.add(Barraca.fromJson(data));
      print(doc["descricao"]);
      print("oba");
    }
  });
  //List<Barraca> list = [];
  // final String response =
  //     await rootBundle.loadString('assets/json/barracas.json');
  // final decodedResponse = await json.decode(response);

  // for (var barraca in decodedResponse) {
  //   list.add(Barraca.fromJson(barraca));
  // }
  return list;
}
