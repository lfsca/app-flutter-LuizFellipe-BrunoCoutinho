import 'package:flutter/material.dart';

import 'models/barraca.dart';

class AddBarracaPage extends StatefulWidget {
  const AddBarracaPage({Key? key}) : super(key: key);

  static const routeName = '/addBarracaPage';

  @override
  State<AddBarracaPage> createState() => _AddBarracaState();
}

class _AddBarracaState extends State<AddBarracaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final donoController = TextEditingController();

  String nome = "";
  String dono = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Barraca'),
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
          donoField(),
        ]));
  }

  Container donoField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextFormField(
        controller: donoController,
        decoration: const InputDecoration(
          hintText: 'Insira o dono',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor insira o dono';
          }
          return null;
        },
      ),
    );
  }

  Container nomeField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextFormField(
        controller: nomeController,
        decoration: const InputDecoration(
          hintText: 'Insira o nome da barraca',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Por favor insira o nome da barraca';
          }
          return null;
        },
      ),
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      icon: const Icon(Icons.arrow_forward, size: 32),
      label: const Text(
        'Adicionar',
        style: TextStyle(fontSize: 24),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          nome = nomeController.text;
          dono = donoController.text;
          // try {
          //   cadastro(nome, email, senha, vendedor);
          // } on FirebaseAuthException catch (e) {
          //   print(e);
          // }
          print("adicionou barraca");
        }
      },
    );
  }
}
