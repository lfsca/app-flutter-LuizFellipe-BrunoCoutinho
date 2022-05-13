class Avaliacao {
  final int nota;
  final String comentario;
  final String autor;
  final String data;

  Avaliacao(
      {this.nota = 0, this.comentario = "", this.autor = "", this.data = ""});
  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
        nota: json['nota'],
        comentario: json['comentario'],
        autor: json['autor'],
        data: json['data']);
  }
}
