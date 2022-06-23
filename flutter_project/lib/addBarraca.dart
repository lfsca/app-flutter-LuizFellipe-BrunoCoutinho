import 'package:flutter/material.dart';

import 'models/barraca.dart';

class AddBarraca extends StatefulWidget {
  const AddBarraca({Key? key}) : super(key: key);

  static const routeName = '/addBarracaPage';

  @override
  State<AddBarraca> createState() => _AddBarracaState();
}

class _AddBarracaState extends State<AddBarraca> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Barraca'),
        ),
        body: Container());
  }
}
