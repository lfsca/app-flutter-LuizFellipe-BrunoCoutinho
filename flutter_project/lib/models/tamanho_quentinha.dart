class TamanhoQuentinha {
  final String tamanho;
  final int quantidade;
  final String preco;

  TamanhoQuentinha({this.tamanho = "a", this.quantidade = 0, this.preco = ""});

  factory TamanhoQuentinha.fromJson(Map<String, dynamic> json) {
    return TamanhoQuentinha(
        tamanho: json['tamanho'],
        quantidade: json['quantidade'],
        preco: json['preco']);
  }
}
