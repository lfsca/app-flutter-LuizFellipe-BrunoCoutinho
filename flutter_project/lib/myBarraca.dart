import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/imagemBarraca.dart';

import 'models/barraca.dart';
import 'models/usuario.dart';

class MyBarracaPage extends StatefulWidget {
  const MyBarracaPage({Key? key}) : super(key: key);

  static const routeName = '/myBarracaPage';

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
                    const SizedBox(height: 40),
                    //formFields(vendedores),
                    const SizedBox(height: 20),
                    //submitButton(),
                  ])),
            )));
  }
}

class EditableImagemBarraca extends StatelessWidget {
  const EditableImagemBarraca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: substituir pele edição de imagem com imgPicker
    return Stack(
      children: [
        ImagemBarraca(imagemPath: "barraca.imagemBarraca!"),
      ],
    );
  }
}

Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: const Icon(
          Icons.add_a_photo,
          color: Colors.white,
          size: 20,
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
