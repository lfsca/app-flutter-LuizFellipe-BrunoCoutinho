import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/imageUpload.dart';
import 'package:flutter_project/imagemBarraca.dart';

import 'models/barraca.dart';
import 'models/usuario.dart';

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
                    ImageUpload(),
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
    // TODO: substituir pele edição de imagem com imgPicker
    final color = Theme.of(context).colorScheme.primary;
    return Stack(
      children: [
        const ImagemBarraca(imagemPath: "barraca.imagemBarraca!"),
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
