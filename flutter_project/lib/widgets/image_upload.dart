import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/providers/barracaImageProvider.dart';
import 'package:flutter_project/widgets/build_edit_icon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../models/barraca.dart';
import 'imagem_barraca.dart';

class ImageUpload extends StatefulWidget {
  ImageUpload({Key? key, required this.barraca}) : super(key: key);

  Barraca barraca;

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  FirebaseStorage storage = FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.black;
    final secondaryColor = Theme.of(context).colorScheme.primary;

    return Stack(
      children: [
        Consumer<ImagePath>(builder: (context, imagePath, child) {
          return ImagemBarraca(url: imagePath.fileName);
        }),
        Positioned(
          bottom: 0,
          right: 4,
          child: BuildEditIcon(
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            // todo callback p funcao q faz escolha entre camera e galeria
            callback: _displayOptionsDialog,
            barraca: widget.barraca,
          ),
        ),
      ],
    );
  }

  Future _displayOptionsDialog(BuildContext context, Barraca barraca) async {
    await _optionsDialogBox(context, barraca);
  }

  Future<void> _optionsDialogBox(BuildContext context, Barraca barraca) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext newContext) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Câmera'),
                    onTap: () => imgFromCamera(context, barraca),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Galeria'),
                    onTap: () => imgFromGallery(context, barraca),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future imgFromGallery(BuildContext context, Barraca barraca) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(context, barraca);
      }
    });
  }

  Future imgFromCamera(BuildContext context, Barraca barraca) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(context, barraca);
      }
    });
  }

  Future uploadFile(BuildContext context, Barraca barraca) async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'imgsBarracas/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    } finally {
      var imagePath = Provider.of<ImagePath>(context, listen: false);
      // deveria colocar nome da img da barraca no banco como
      imagePath.setFileName(destination);
      final docBarraca = FirebaseFirestore.instance
          .collection('barraca')
          .doc('TKBAzTHj8Ue2ZmkHNiLb');
      try {
        docBarraca.update({'imagemBarraca': destination});
      } catch (error) {
        print("Falha ao editar barraca: $error");
      }
    }
  }
}
