import 'package:flutter/material.dart';

import 'models/barraca.dart';
import 'models/usuario.dart';

class AddBarracaPage extends StatefulWidget {
  const AddBarracaPage({Key? key}) : super(key: key);

  static const routeName = '/addBarracaPage';

  @override
  State<AddBarracaPage> createState() => _AddBarracaState();
}

class _AddBarracaState extends State<AddBarracaPage> {
  final Future<List<Usuario>> vendedores = fetchVendedores();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Usuario vendedorField;
  final nomeController = TextEditingController();

  String nome = "";
  late Usuario vendedor;

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
                    formFields(vendedores),
                    const SizedBox(height: 20),
                    submitButton(),
                  ])),
            )));
  }

  Card formFields(Future<List<Usuario>> vendedores) {
    return Card(
        color: const Color.fromARGB(222, 250, 250, 250),
        child: Column(children: [
          nomeField(),
          const SizedBox(height: 40),
          donoField(vendedores),
        ]));
  }

  List<DropdownMenuItem> _getVendedorMenuItems(List<Usuario>? vendedores) {
    List<DropdownMenuItem> vendedorItems = [];
    for (var vendedor in vendedores!) {
      vendedorItems
          .add(DropdownMenuItem(child: Text(vendedor.nome), value: vendedor));
    }
    return vendedorItems;
  }

  Container donoField(Future<List<Usuario>> vendedores) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder<List<Usuario>>(
            future: vendedores,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DropdownMenuItem> vendedorItems =
                    _getVendedorMenuItems(snapshot.data);
                return DropdownButtonFormField(
                    value: snapshot.data?[0],
                    items: vendedorItems,
                    hint: const Text("Escolha o dono da barraca"),
                    decoration: const InputDecoration(
                      labelText: 'Dono da barraca',
                    ),
                    onChanged: (dynamic vendedorValue) {
                      final snackBar = SnackBar(
                        content: Text(
                          'Dono escolhido: ${vendedorValue.nome}',
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {
                        vendedor = vendedorValue;
                      });
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return const CircularProgressIndicator();
              }
            }));
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
          vendedor = vendedorField;
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
