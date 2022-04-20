import 'package:flutter/material.dart';
import 'package:flutter_project/barraca.dart';
import 'package:flutter_project/style.dart';

class DetailPage extends StatelessWidget {
  final Barraca barraca;

  DetailPage(this.barraca);

  @override
  Widget build(BuildContext context) {
    Widget _getContent() {
      return Container(
          child: Center(
        child: Column(children: [
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Text('Descricao: ${barraca.descricao}', style: Style.commonTextStyle),
          Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0),
          Text('Cardapio: ${barraca.cardapio}', style: Style.commonTextStyle)
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
