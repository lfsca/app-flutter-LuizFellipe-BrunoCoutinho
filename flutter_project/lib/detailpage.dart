import 'package:flutter/material.dart';
import 'package:flutter_project/barraca.dart';
import 'package:flutter_project/quentinha.dart';
import 'package:flutter_project/reviewpage.dart';
import 'package:flutter_project/style.dart';
import 'package:flutter_project/palette.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  static const routeName = '/detailpage';

  @override
  Widget build(BuildContext context) {
    final barraca = ModalRoute.of(context)!.settings.arguments as Barraca;
    return Scaffold(
        appBar: AppBar(title: Text(barraca.nomeBarraca)),
        body: Container(
            color: const Color.fromARGB(218, 250, 227, 227),
            constraints: const BoxConstraints.expand(),
            child: ListView(
              children: <Widget>[
                if (barraca.imagemBarraca != "IMAGEM")
                  exibeImagemBarraca(barraca),
                WidgetResumoBarraca(barraca: barraca),
                for (var quentinha in barraca.quentinhas)
                  WidgetQuentinha(quentinha: quentinha)
              ],
            )));
  }

  GestureDetector exibeImagemBarraca(Barraca barraca) {
    return GestureDetector(
        onDoubleTap: () {
          ImageDialog(barraca.imagemBarraca);
        },
        child: (Image.asset(
          barraca.imagemBarraca,
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
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ReviewPage.routeName,
              arguments: barraca);
        },
        child: Container(
            margin: EdgeInsets.all(20), child: Text(barraca.descricao)));
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
      margin: EdgeInsets.all(20),
      height: 100,
      width: double.infinity,
      child: Card(
          color: createMaterialColor(Color.fromARGB(255, 253, 202, 168)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              )),
          child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(children: [
                Container(
                    child: Center(
                  child: Text(quentinha.nome, style: Style.headerTextStyle),
                )),
              ]))),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String imagemBarraca;
  ImageDialog(this.imagemBarraca);

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
