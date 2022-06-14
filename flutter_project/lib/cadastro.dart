import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const routeName = '/registerpage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isChecked = false;
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro'),
        ),
        body: Container(
          color: const Color.fromARGB(218, 160, 209, 219),
          child: Container(
            margin: EdgeInsets.all(16),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Card(
                  color: Color.fromARGB(222, 250, 250, 250),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.all(16),
                      child: TextFormField(
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
                    ),
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: TextFormField(
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
                    ),
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: TextFormField(
                        controller: registersenhaController,
                        obscureText: true,
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
                    ),
                    SizedBox(height: 40),
                    Row(children: [
                      Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                      Text("É vendedor?"),
                    ]),
                  ])),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.arrow_forward, size: 32),
                label: Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  nome = registernomeController.text;
                  email = registeremailController.text;
                  senha = registersenhaController.text;
                  vendedor = isChecked;
                  try {
                    cadastro(nome, email, senha, vendedor);
                  } on FirebaseAuthException catch (e) {
                    print(e);
                  }
                },
              ),
            ]),
          ),
        ));
  }

  Future cadastro(
      String nome, String email, String senha, bool vendedor) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: senha.trim(),
      );
      final uid = FirebaseAuth.instance.currentUser?.uid;
      addUser(uid, nome, email, vendedor);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future addUser(uid, String nome, String email, bool vendedor) async {
    final usuario = FirebaseFirestore.instance.collection('usuario').doc(uid);
    // Call the user's CollectionReference to add a new user

    try {
      final json = {
        'nome': nome,
        'email': email,
        'vendedor': vendedor,
        'administrador': false,
      };
      await usuario.set(json);
    } catch (error) {
      print("Falha ao criar usuario: $error");
    }
    print("Usuario Criado!");
  }

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
}
