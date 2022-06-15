import 'package:cloud_firestore/cloud_firestore.dart';

class Avaliacao {
  final int nota;
  final String comentario;
  final String autor;
  final DateTime data;

  Avaliacao(
      {this.nota = 0,
      this.comentario = "",
      this.autor = "",
      required this.data});
  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
        nota: json['nota'],
        comentario: json['comentario'],
        autor: json['autor'],
        data: (json['data']).toDate());
    //data: DateTime.parse(json['data']));
  }
}
