import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/models/quentinha.dart';
import 'package:flutter_project/models/avaliacao.dart';

class Barraca {
  final String nomeBarraca;
  final String? descricao;
  final String? imagemBarraca;
  final List<Avaliacao>? avaliacoes;
  final List<Quentinha>? quentinhas;
  final double? lat;
  final double? ln;

  Barraca({
    required this.nomeBarraca,
    this.descricao = "Sem descrição",
    this.imagemBarraca,
    this.avaliacoes,
    this.quentinhas,
    this.lat,
    this.ln,
  });

  factory Barraca.fromFirestore(Map<String, dynamic>? data) {
    List<Quentinha> listaQuentinhas = [];
    List<Avaliacao> listaAvaliacoes = [];

    if (data?.containsKey("quentinhas") ?? false) {
      for (var quentinha in data?['quentinhas']) {
        listaQuentinhas.add(Quentinha.fromJson(quentinha));
      }
    }

    if (data?.containsKey("avaliacoes") ?? false) {
      for (var avaliacao in data?['avaliacoes']) {
        listaAvaliacoes.add(Avaliacao.fromJson(avaliacao));
      }
    }

    return Barraca(
      nomeBarraca: data?['nomeBarraca'],
      descricao: data?['descricao'],
      imagemBarraca: data?['imagemBarraca'],
      avaliacoes: listaAvaliacoes,
      quentinhas: listaQuentinhas,
      lat: data?['lat'],
      ln: data?['ln'],
    );
  }

  bool hasAvaliacao() => avaliacoes!.isNotEmpty;

  double calculaMediaAvaliacoes() {
    double media = 0;
    if (avaliacoes != null) {
      for (var avaliacao in avaliacoes!) {
        media += avaliacao.nota;
      }
      media = media / avaliacoes!.length;
    }
    return media;
  }

  String getImgPath() {
    if (imagemBarraca != null) {
      return imagemBarraca!;
    }
    return "imgsBarracas/default_image.jpg";
  }
}

Future<List<Barraca>> fetchBarracas() async {
  List<Barraca> list = [];
  await FirebaseFirestore.instance
      .collection('barraca')
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      list.add(Barraca.fromFirestore(data));
    }
  });
  return list;
}
