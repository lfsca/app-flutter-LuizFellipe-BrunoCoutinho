import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  static const routeName = '/registerform';

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final registernomeController = TextEditingController();
  final registersenhaController = TextEditingController();
  final registeremailController = TextEditingController();
  final registervendedorController = TextEditingController();

  String nome = "";
  String senha = "";
  String email = "";
  bool vendedor = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference usuario =
        FirebaseFirestore.instance.collection('usuario');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hora do Rango PUC-Rio'),
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegisterForm.routeName);
            },
            child: Icon(
              Icons.menu,
            )),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: registernomeController,
                    decoration: const InputDecoration(
                      hintText: 'Insira seu nome completo',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira seu nome';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: registeremailController,
                    decoration: const InputDecoration(
                      hintText: 'Insira seu email',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira seu email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: registersenhaController,
                    decoration: const InputDecoration(
                      hintText: 'Insira uma senha',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira uma senha';
                      }
                      return null;
                    },
                  ),
                  CheckboxWidget(),
                  Text("E vendedor?"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        nome = registernomeController.text;
                        email = registeremailController.text;
                        senha = registersenhaController.text;
                        vendedor = false;
                        if (_formKey.currentState!.validate()) {
                          addUser(usuario, nome, email, senha, vendedor);
                        }
                      },
                      child: const Text('Criar'),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Future<void> addUser(CollectionReference<Object?> usuario, String nome,
      String email, String senha, bool vendedor) {
    // Call the user's CollectionReference to add a new user
    return usuario
        .add({
          'nome': nome,
          'email': email,
          'senha': senha,
          'vendedor': vendedor,
        })
        .then((value) => print("Usuario Criado!"))
        .catchError((error) => print("Falha ao criar usuario: $error"));
  }
}

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({Key? key}) : super(key: key);

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.black;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
