import 'package:flutter/material.dart';

class ImagePath extends ChangeNotifier {
  String _fileName = "";
  ImagePath(String fileName) {
    _fileName = fileName;
  }

  String get fileName => _fileName;

  void setFileName(String newFileName) {
    _fileName = newFileName;
    notifyListeners();
  }
}
