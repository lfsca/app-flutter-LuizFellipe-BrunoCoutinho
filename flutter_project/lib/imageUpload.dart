import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/providers/barracaImageProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'imagemBarraca.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

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
              callback: imgFromCamera),
        ),
      ],
    );
  }

  Future imgFromGallery(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(context);
      }
    });
  }

  Future imgFromCamera(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(context);
      }
    });
  }

  Future uploadFile(BuildContext context) async {
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
      imagePath.setFileName(
          "imgsBarracas/c2574eef-c55e-4dfb-a747-df3872d546ee1516213396568976974.jpg");
    }
  }
}

class BuildEditIcon extends StatelessWidget {
  Color primaryColor;
  Color secondaryColor;
  Function(BuildContext) callback;

  BuildEditIcon(
      {Key? key,
      required this.primaryColor,
      required this.secondaryColor,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCircle(
      color: primaryColor,
      all: 3,
      child: buildCircle(
        color: secondaryColor,
        all: 7,
        child: IconButton(
          icon: const Icon(Icons.edit),
          color: Colors.black,
          iconSize: 32,
          //onPressed: () => print("pressionou"),
          onPressed: () => callback(context),
        ),
      ),
    );
  }
}

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
