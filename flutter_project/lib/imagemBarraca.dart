import 'package:flutter/material.dart';

class ImagemBarraca extends StatelessWidget {
  const ImagemBarraca({Key? key, required this.imagemPath}) : super(key: key);

  final String imagemPath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagemPath,
      width: 250.0,
      height: 300.0,
      fit: BoxFit.fitWidth,
    );
  }
}
