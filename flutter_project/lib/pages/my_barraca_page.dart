import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/image_upload.dart';
import 'package:flutter_project/providers/barracaImageProvider.dart';
import 'package:provider/provider.dart';

import '../models/barraca.dart';
import '../models/usuario.dart';
import 'login_page.dart';

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
  final descricaoController = TextEditingController();
  final coordenadasController = TextEditingController();
  final quentinhasController = TextEditingController();

  String nome = "";
  String descricao = "";
  late Usuario vendedor;

  @override
  Widget build(BuildContext context) {
    final barraca = ModalRoute.of(context)!.settings.arguments as Barraca;
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
                      create: (context) => ImagePath(barraca.getImgPath()),
                      child: ImageUpload(
                        barraca: barraca,
                      ),
                    ),
                    const SizedBox(height: 40),
                    formFields(),
                    const SizedBox(height: 20),
                    submitButton(),
                  ])),
            )));
  }

  Card formFields() {
    return Card(
        color: const Color.fromARGB(222, 250, 250, 250),
        child: Column(children: [
          nomeField(),
          const SizedBox(height: 40),
          descricaoField(),
          const SizedBox(height: 40),
          coordenadasField(),
          const SizedBox(height: 40),
          quentinhasField()
        ]));
  }

  Container nomeField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextFormField(
        controller: nomeController,
        decoration: const InputDecoration(
          labelText: 'Nome',
          hintText: 'Insira o nome da barraca',
        ),
        // validator: (String? value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Por favor insira o nome da barraca';
        //   }
        //   return null;
        // },
      ),
    );
  }

  Container descricaoField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextFormField(
        controller: descricaoController,
        decoration: const InputDecoration(
          labelText: 'descricao',
          hintText: 'Insira a descrição da barraca',
        ),
        // validator: (String? value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Por favor insira a descrição da barraca';
        //   }
        //   return null;
        // },
      ),
    );
  }

  Container coordenadasField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextFormField(
        controller: coordenadasController,
        enabled: false,
        readOnly: true,
        decoration: const InputDecoration(
          labelText: 'coordenadas',
          hintText: 'Insira as coordenadas da barraca',
        ),
        // validator: (String? value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Por favor insira as coordenadas da barraca';
        //   }
        //   return null;
        // },
      ),
    );
  }

  Container quentinhasField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextFormField(
        controller: quentinhasController,
        enabled: false,
        readOnly: true,
        decoration: const InputDecoration(
          labelText: 'quentinhas',
          hintText: 'Insira as quentinhas da barraca',
        ),
        // validator: (String? value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Por favor insira as quentinhas da barraca';
        //   }
        //   return null;
        // },
      ),
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      icon: const Icon(Icons.check, size: 32),
      label: const Text(
        'Salvar',
        style: TextStyle(fontSize: 24),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          nome = nomeController.text;
          descricao = descricaoController.text;
          salvar('TKBAzTHj8Ue2ZmkHNiLb', nome, descricao);
        }
      },
    );
  }

  Future salvar(uid, String? nome, String? descricao) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    final docBarraca =
        FirebaseFirestore.instance.collection('barraca').doc(uid);
    if (nome != null) {
      try {
        docBarraca.update({'nomeBarraca': nome});
      } catch (error) {
        print("Falha ao editar barraca: $error");
      }
    }
    ;
    if (descricao != null) {
      try {
        docBarraca.update({'descricao': descricao});
      } catch (error) {
        print("Falha ao editar barraca: $error");
      }
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
