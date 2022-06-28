import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter_project/imagemBarraca.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(218, 160, 209, 219);
    final secondaryColor = Theme.of(context).colorScheme.primary;

    return Stack(
      children: [
        const ImagemBarraca(imagemPath: "assets/img/milos.jpeg"),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(primaryColor, secondaryColor, imgFromCamera),
        ),
      ],
    );
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future testeCallback() async {
    print("chegou no callback");
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'imgsBarracas/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }
}

Widget buildEditIcon(
        Color primaryColor, Color secondaryColor, VoidCallback callback) =>
    buildCircle(
      color: primaryColor,
      all: 3,
      child: buildCircle(
        color: secondaryColor,
        all: 7,
        child: IconButton(
          icon: const Icon(Icons.edit),
          color: Colors.black,
          iconSize: 32,
          onPressed: callback,
        ),
      ),
    );

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
