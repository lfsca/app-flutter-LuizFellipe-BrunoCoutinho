class Barraca {
  final String id;
  final String nomeBarraca;
  final String descricao;
  final String cardapio;
  final String imagemBarraca;

  Barraca({
    this.id = "a",
    this.nomeBarraca = "a",
    this.descricao = "a",
    this.cardapio = "a",
    this.imagemBarraca = "a",
  });
}

List<Barraca> barracas = [
  Barraca(
    id: "1",
    nomeBarraca: "Barraca do Milos",
    descricao: "Salgados e PFs",
    cardapio: "Feijao Tropeiro, Panqueca de Carne, Strogonoff de Frango",
    imagemBarraca: "IMAGEM",
  ),
  Barraca(
    id: "2",
    nomeBarraca: "Barraca do Amarelinho",
    descricao: "Yakisobas e Salgadinhos",
    cardapio: "Yakisobas e Jacalhau",
    imagemBarraca: "IMAGEM",
  ),
  Barraca(
    id: "3",
    nomeBarraca: "Barraca do Churrasquinho",
    descricao: "Churrasquinhos e PFs",
    cardapio: "Churrasquinhos e PF de Churrasquinho",
    imagemBarraca: "IMAGEM",
  ),
];
