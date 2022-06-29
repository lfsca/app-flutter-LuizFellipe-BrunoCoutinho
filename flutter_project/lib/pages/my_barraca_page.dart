import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/image_upload.dart';
import 'package:flutter_project/widgets/imagem_barraca.dart';
import 'package:flutter_project/providers/barracaImageProvider.dart';
import 'package:provider/provider.dart';

import '../models/barraca.dart';
import '../models/usuario.dart';

class MyBarracaPage extends StatefulWidget {
  static const routeName = '/myBarracaPage';

  const MyBarracaPage({Key? key}) : super(key: key);

  @override
  State<MyBarracaPage> createState() => _MyBarracaState();
}

class _MyBarracaState extends State<MyBarracaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Usuario vendedorField;
  final nomeController = TextEditingController();

  String nome = "";
  late Usuario vendedor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Minha Barraca'),
        ),
        body: Container(
            color: const Color.fromARGB(218, 160, 209, 219),
            constraints: const BoxConstraints.expand(),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    ChangeNotifierProvider(
                      create: (context) => ImagePath(
                          "imgsBarracas/0424ec5a-0777-4f5c-908e-d8334b9c34663975699593506526289.jpg"),
                      child: const ImageUpload(),
                    ),
                    const SizedBox(height: 40),
                    //formFields(vendedores),
                    //const SizedBox(height: 20),
                    //submitButton(),
                  ])),
            )));
  }
}

class EditableImagemBarraca extends StatelessWidget {
  const EditableImagemBarraca({Key? key, required this.callback})
      : super(key: key);

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Stack(
      children: [
        const ImagemBarraca(url: "barraca.imagemBarraca!"),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(color, callback),
        ),
      ],
    );
  }
}

Widget buildEditIcon(Color color, VoidCallback callback) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: IconButton(
          icon: const Icon(Icons.add_a_photo),
          color: Colors.white,
          iconSize: 20,
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
