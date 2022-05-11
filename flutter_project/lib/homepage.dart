import 'package:flutter/material.dart';
import 'package:flutter_project/gradientappbar.dart';
import 'package:flutter_project/detailpage.dart';
import 'package:flutter_project/barraca.dart';
import 'dart:async';
import 'package:flutter_project/style.dart';
import 'package:flutter_project/palette.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hora do Rango PUC-Rio')),
        body: Container(
            color: Color.fromARGB(218, 250, 227, 227),
            child: Center(
                child: Column(children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: barracas.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(20),
                          height: 100,
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, DetailPage.routeName,
                                  arguments: barracas[index]);
                            },
                            child: Card(
                                color: createMaterialColor(
                                    Color.fromARGB(255, 247, 212, 188)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1,
                                    )),
                                child: Container(
                                    width: 100,
                                    height: 100,
                                    child: Column(children: [
                                      Container(
                                          padding: EdgeInsets.only(right: 16.0),
                                          child: Align(
                                              alignment: Alignment.topRight,
                                              child: const Estrela())),
                                      Center(
                                        child: Text(barracas[index].nomeBarraca,
                                            style: Style.headerTextStyle),
                                      )
                                    ]))),
                          ),
                        );
                      })),
            ]))));
  }
}

// class ImageDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         width: 200,
//         height: 200,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: ExactAssetImage("assets/img/estrela.png"),
//                 fit: BoxFit.cover)),
//       ),
//     );
//   }
// }

class Estrela extends StatefulWidget {
  const Estrela({Key? key}) : super(key: key);

  @override
  _EstrelaState createState() => _EstrelaState();
}

class _EstrelaState extends State<Estrela> {
  bool _isFavorited = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onDoubleTap: _toggleFavorite,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        alignment: Alignment.centerRight,
        icon: (_isFavorited
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border)),
        color: Color.fromARGB(186, 250, 235, 100),
        onPressed: () {},
      ),
    ));
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }
}
