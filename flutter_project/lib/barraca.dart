import 'package:flutter/services.dart';
import 'package:flutter_project/quentinha.dart';
import 'package:flutter_project/avaliacao.dart';
import 'dart:convert';

class Barraca {
  final int id;
  final String nomeBarraca;
  final String descricao;
  final String imagemBarraca;
  final List<Avaliacao> avaliacoes;
  final List<Quentinha> quentinhas;

  Barraca(
      {this.id = 0,
      this.nomeBarraca = "a",
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
        id: json['id'],
        nomeBarraca: json['nomeBarraca'],
        descricao: json['descricao'],
        imagemBarraca: json['imagemBarraca'],
        avaliacoes: listaAvaliacoes,
        quentinhas: listaQuentinhas);
  }
}

Future<List<Barraca>> fetchBarracas() async {
  List<Barraca> list = [];
  final String response =
      await rootBundle.loadString('assets/json/barracas.json');
  final decodedResponse = await json.decode(response);

  for (var barraca in decodedResponse) {
    print('Ó A BARRACA: $barraca');
    list.add(Barraca.fromJson(barraca));
  }
  return list;
}

// List<Barraca> barracas = [
//   Barraca(
//       id: "1",
//       nomeBarraca: "Barraca do Milos",
//       descricao: "Salgados e PFs",
//       cardapio: "Feijao Tropeiro, Panqueca de Carne, Strogonoff de Frango",
//       imagemBarraca: "assets/img/milos.jpeg",
//       avaliacoes: <Review>[
//         Review(autor: "ivv", nota: 10, comentario: "bbos"),
//         Review(
//             autor: "Mariana Salgueiro",
//             nota: 10,
//             comentario: "A maior gostosa do planeta")
//       ]),
//   Barraca(
//       id: "2",
//       nomeBarraca: "Barraca do Amarelinho",
//       descricao: "Yakisobas e Salgadinhos",
//       cardapio: "Yakisobas e Jacalhau",
//       imagemBarraca: "assets/img/amarelinho.jpeg",
//       avaliacoes: <Review>[
//         Review(autor: "ivv", nota: 10, comentario: "bbos"),
//         Review(
//             autor: "Mariana Salgueiro",
//             nota: 10,
//             comentario: "A maior gostosa do planeta")
//       ]),
//   Barraca(
//       id: "3",
//       nomeBarraca: "Barraca do Churrasquinho",
//       descricao: "Churrasquinhos e PFs",
//       cardapio: "Churrasquinhos e PF de Churrasquinho",
//       imagemBarraca: "assets/img/churrasquinho.jpeg",
//       avaliacoes: <Review>[
//         Review(autor: "ivv", nota: 10, comentario: "bbos"),
//         Review(
//             autor: "Mariana Salgueiro",
//             nota: 10,
//             comentario: "A maior gostosa do planeta")
//       ]),
//   Barraca(
//       id: "4",
//       nomeBarraca: "Barraca do Kakumi",
//       descricao: "Cozinha Oriental",
//       cardapio: "Wraps, Arroz Oriental com Frango e Yakisoba",
//       imagemBarraca: "assets/img/kakumi.jpeg",
//       avaliacoes: <Review>[
//         Review(autor: "ivv", nota: 10, comentario: "bbos"),
//         Review(
//             autor: "Mariana Salgueiro",
//             nota: 10,
//             comentario: "A maior gostosa do planeta")
//       ]),
//   Barraca(
//       id: "5",
//       nomeBarraca: "Barraca do Strogonoff",
//       descricao: "Strogonoff",
//       cardapio: "Strogonoff de Frango, Carne e Abobrinha",
//       imagemBarraca: "assets/img/strogonoff.jpeg",
//       avaliacoes: <Review>[
//         Review(autor: "ivv", nota: 10, comentario: "bbos"),
//         Review(
//             autor: "Mariana Salgueiro",
//             nota: 10,
//             comentario: "A maior gostosa do planeta")
//       ]),
//   Barraca(
//       id: "6",
//       nomeBarraca: "Barraca da Joaninha",
//       descricao: "Doces e PFs",
//       cardapio:
//           "Panqueca sem recheio, Feijoada sem Feijao e Peixe sem acompanhamento",
//       imagemBarraca: "assets/img/joaninha.jpeg",
//       avaliacoes: <Review>[
//         Review(autor: "ivv", nota: 10, comentario: "bbos"),
//         Review(
//             autor: "Mariana Salgueiro",
//             nota: 10,
//             comentario: "A maior gostosa do planeta")
//       ]),
// ];
