import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatelessWidget {
  final String nome;
  final String email;
  final String senha;
  final bool vendedor;

  static const routeName = '/registerpage';

  RegisterPage(this.nome, this.email, this.senha, this.vendedor);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference usuario =
        FirebaseFirestore.instance.collection('usuario');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return usuario
          .add({
            'nome': nome, // John Doe
            'email': email, // Stokes and Sons
            'senha': senha, // 42
            'vendedor': false,
          })
          .then((value) => print("Usuario Criado!"))
          .catchError((error) => print("Falha ao criar usuario: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Criar usuario",
      ),
    );
  }
}
