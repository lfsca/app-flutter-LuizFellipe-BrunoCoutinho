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

  @override
  Widget build(BuildContext context) {
    CollectionReference usuario =
        FirebaseFirestore.instance.collection('usuario');
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Insira seu email',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          addUser(usuario, "Luiz", "emailteste", "batatinha",
                              false);
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

// class RegisterData extends StatelessWidget {
//   final String nome;
//   final String email;
//   final String senha;
//   final bool vendedor;

//   RegisterData(this.nome, this.email, this.senha, this.vendedor);

//   @override
//   Widget build(BuildContext context) {
//     // Create a CollectionReference called users that references the firestore collection
//     CollectionReference usuario =
//         FirebaseFirestore.instance.collection('usuario');



//     return addUser(),
//   }
// }
