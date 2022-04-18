import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:projeto_flutter/gradientappbar.dart';
import 'package:projeto_flutter/homepagebody.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          GradientAppBar("Planets"),
          HomePageBody(),
        ],
      ),
    );
  }
}
