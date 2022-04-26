import 'package:flutter/material.dart';
import 'package:flutter_project/barraca.dart';
import 'package:flutter_project/style.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  static const routeName = '/detailpage';

  @override
  Widget build(BuildContext context) {
    final barraca = ModalRoute.of(context)!.settings.arguments as Barraca;
    Widget _getContent() {
      return Container(
          child: Center(
        child: Column(children: [
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Text('Descricao:', style: Style.headerTextStyle),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Text('${barraca.descricao}', style: Style.commonTextStyle),
          Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0),
          Center(child: Text('Cardapio:', style: Style.headerTextStyle)),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Text('${barraca.cardapio}', style: Style.commonTextStyle),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          if (barraca.imagemBarraca != "IMAGEM")
            (Image.asset(
              barraca.imagemBarraca,
              width: 250.0,
              height: 250.0,
            )),
        ]),
      ));
    }

    // Container _getToolbar(BuildContext context) {
    //   return Container(
    //     margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    //     child: BackButton(
    //       color: Colors.blue,
    //     ),
    //   );
    // }

    return Scaffold(
        appBar: AppBar(title: Text(barraca.nomeBarraca)),
        body: Container(
            color: Color(0xFF736AB7),
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: <Widget>[
                _getContent(),
                // _getToolbar(context),
              ],
            )));
  }
}
