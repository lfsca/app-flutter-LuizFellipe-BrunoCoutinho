import 'package:flutter_project/tamanho_quentinha.dart';

class Quentinha {
  final String nome;
  final String descricao;
  final List<TamanhoQuentinha> tamanhos;

  Quentinha({this.nome = "a", this.descricao = "a", required this.tamanhos});

  factory Quentinha.fromJson(Map<String, dynamic> json) {
    List<TamanhoQuentinha> listaTamanhos = [];

    for (var tamanho in json['tamanhos']) {
      listaTamanhos.add(TamanhoQuentinha.fromJson(tamanho));
    }
    return Quentinha(
        nome: json['nome'],
        descricao: json['descricao'],
        tamanhos: listaTamanhos);
  }
}
