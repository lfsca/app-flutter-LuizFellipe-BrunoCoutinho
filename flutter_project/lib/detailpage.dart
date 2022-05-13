import 'package:flutter/material.dart';
import 'package:flutter_project/barraca.dart';
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
            color: Color.fromARGB(218, 250, 227, 227),
            constraints: BoxConstraints.expand(),
            child: Center(
                child: Column(children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              if (barraca.imagemBarraca != "IMAGEM")
                GestureDetector(
                    onDoubleTap: () {
                      ImageDialog(barraca.imagemBarraca);
                    },
                    child: (Image.asset(
                      barraca.imagemBarraca,
                      width: 250.0,
                      height: 250.0,
                    ))),
              const SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.all(20), child: Text(barraca.descricao)),
              Expanded(
                  child: ListView.builder(
                      itemCount: barraca.quentinhas.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(20),
                          height: 100,
                          width: double.infinity,
                          child: Card(
                              color: createMaterialColor(
                                  Color.fromARGB(255, 253, 202, 168)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  )),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ReviewPage.routeName,
                                        arguments: barraca);
                                  },
                                  child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Stack(children: [
                                        Container(
                                            child: Center(
                                          child: Text(
                                              barraca.quentinhas[index].nome,
                                              style: Style.headerTextStyle),
                                        )),
                                      ])))),
                        );
                      }))
            ]))));
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
