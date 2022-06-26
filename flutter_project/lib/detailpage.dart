import 'package:flutter/material.dart';
import 'package:flutter_project/models/barraca.dart';
import 'package:flutter_project/models/quentinha.dart';
import 'package:flutter_project/reviewpage.dart';
import 'package:flutter_project/style/palette.dart';
import 'package:flutter_project/models/tamanho_quentinha.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  static const routeName = '/detailpage';

  @override
  Widget build(BuildContext context) {
    final barraca = ModalRoute.of(context)!.settings.arguments as Barraca;
    return Scaffold(
        appBar: AppBar(title: Text(barraca.nomeBarraca)),
        body: Container(
            color: const Color.fromARGB(218, 160, 209, 219),
            constraints: const BoxConstraints.expand(),
            child: ListView(
              children: <Widget>[
                if (barraca.imagemBarraca != "IMAGEM")
                  exibeImagemBarraca(barraca),
                WidgetResumoBarraca(barraca: barraca),
                if (barraca.quentinhas != null)
                  for (var quentinha in barraca.quentinhas!)
                    WidgetQuentinha(quentinha: quentinha)
              ],
            )));
  }

  GestureDetector exibeImagemBarraca(Barraca barraca) {
    return GestureDetector(
        onDoubleTap: () {
          ImageDialog(barraca.imagemBarraca!);
        },
        child: (Image.asset(
          barraca.imagemBarraca!,
          width: 250.0,
          height: 250.0,
        )));
  }
}

class WidgetResumoBarraca extends StatelessWidget {
  const WidgetResumoBarraca({
    Key? key,
    required this.barraca,
  }) : super(key: key);

  final Barraca barraca;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(barraca.nomeBarraca,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(barraca.descricao ?? "Sem descrição",
              style: const TextStyle(fontSize: 16))),
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ReviewPage.routeName,
                arguments: barraca);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (barraca.hasAvaliacao())
                RatingBar(
                  initialRating: barraca.calculaMediaAvaliacoes(),
                  direction: Axis.horizontal,
                  ignoreGestures: true,
                  allowHalfRating: true,
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
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                    barraca.avaliacoes?.length.toString() ?? "0" " Avaliações"),
              ),
              const Icon(Icons.arrow_right)
            ],
          ))
    ]);
  }
}

class WidgetQuentinha extends StatelessWidget {
  const WidgetQuentinha({
    Key? key,
    required this.quentinha,
  }) : super(key: key);

  final Quentinha quentinha;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      child: Card(
          color: createMaterialColor(const Color.fromARGB(222, 250, 250, 250)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              )),
          child: SizedBox(
              width: 100,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(quentinha.nome,
                          style: const TextStyle(fontSize: 24))),
                  Text(quentinha.descricao),
                  const Divider(color: Colors.black),
                  for (var tamanho in quentinha.tamanhos)
                    WidgetTamanhoQuentinha(tamanho: tamanho)
                ],
              ))),
    );
  }
}

class WidgetTamanhoQuentinha extends StatelessWidget {
  const WidgetTamanhoQuentinha({
    Key? key,
    required this.tamanho,
  }) : super(key: key);

  final TamanhoQuentinha tamanho;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(tamanho.tamanho),
        Text("R\$ " + tamanho.preco),
        Text(tamanho.quantidade.toString() + " quentinhas")
      ],
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String imagemBarraca;
  const ImageDialog(this.imagemBarraca, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(imagemBarraca), fit: BoxFit.cover)),
      ),
    );
  }
}
