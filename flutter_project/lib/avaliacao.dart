class Avaliacao {
  final int nota;
  final String comentario;
  final String autor;
  //data?

  Avaliacao({this.nota = 0, this.comentario = "", this.autor = ""});
  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
        nota: json['nota'],
        comentario: json['comentario'],
        autor: json['autor']);
  }
}
