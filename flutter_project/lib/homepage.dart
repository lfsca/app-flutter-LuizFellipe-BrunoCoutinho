import 'package:flutter/material.dart';
import 'package:flutter_project/gradientappbar.dart';

final List<String> entries = <String>[
  'Barraca A',
  'Barraca B',
  'Barraca C',
  'Barraca D',
  'Barraca E',
  'Barraca F',
  'Barraca G',
  'Barraca H',
  'Barraca I',
  'Barraca J'
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('QUEMtinhas')),
        body: Center(
            child: Column(children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      height: 100,
                      width: double.infinity,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1,
                              )),
                          child: Container(
                              color: Colors.white,
                              width: 100,
                              height: 100,
                              child: Center(child: Text('${entries[index]}')))),
                    );
                  })),
        ])));
  }
}
