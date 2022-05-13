import 'package:flutter/material.dart';
import 'package:flutter_project/avaliacao.dart';
import 'package:flutter_project/palette.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'barraca.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  static const routeName = '/reviewpage';
  @override
  Widget build(BuildContext context) {
    final barraca = ModalRoute.of(context)!.settings.arguments as Barraca;
    return Scaffold(
      appBar: AppBar(
        title: Text("Avaliações ${barraca.nomeBarraca}"),
      ),
      body: Container(
          color: const Color.fromARGB(218, 160, 209, 219),
          constraints: const BoxConstraints.expand(),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 20),
              resumoAvaliacoes(barraca),
              for (var avaliacao in barraca.avaliacoes)
                containerAvaliacao(avaliacao)
            ],
          )),
    );
  }

  Column resumoAvaliacoes(Barraca barraca) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(barraca.calculaMediaAvaliacoes().toStringAsFixed(1),
                style: const TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold))),
        Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                RatingBar(
                  initialRating: barraca.calculaMediaAvaliacoes(),
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemSize: 24,
                  ratingWidget: RatingWidget(
                    empty: const Icon(Icons.star_outline,
                        color: Color.fromARGB(255, 255, 230, 0)),
                    half: const Icon(Icons.star_half,
                        color: Color.fromARGB(255, 255, 230, 0)),
                    full: const Icon(Icons.star,
                        color: Color.fromARGB(255, 255, 230, 0)),
                  ),
                  onRatingUpdate: (value) {},
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )),
        Text("${barraca.avaliacoes.length} avaliações no último ano")
      ],
    );
  }

  Container containerAvaliacao(Avaliacao avaliacao) {
    return Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: Card(
            color:
                createMaterialColor(const Color.fromARGB(222, 250, 250, 250)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                )),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        Text(avaliacao.autor,
                            style: const TextStyle(fontSize: 16)),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    )),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: RatingBar(
                          initialRating: avaliacao.nota.toDouble(),
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 5,
                          itemSize: 24,
                          ratingWidget: RatingWidget(
                            empty: const Icon(Icons.star_outline,
                                color: Color.fromARGB(255, 255, 230, 0)),
                            half: const Icon(Icons.star_half,
                                color: Color.fromARGB(255, 255, 230, 0)),
                            full: const Icon(Icons.star,
                                color: Color.fromARGB(255, 255, 230, 0)),
                          ),
                          onRatingUpdate: (value) {},
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(avaliacao.data)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(avaliacao.comentario, softWrap: true),
                )
              ],
            )));
  }
}
