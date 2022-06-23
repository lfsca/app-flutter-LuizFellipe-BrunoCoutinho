import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_email/main.dart';
// import 'package:firebase_auth_email/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/homepage.dart';
import 'package:flutter_project/models/barraca.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Container(
            color: const Color.fromARGB(218, 160, 209, 219),
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                        color: const Color.fromARGB(222, 250, 250, 250),
                        child: Column(children: [
                          Container(
                            margin: const EdgeInsets.all(16),
                            child: TextField(
                              controller: emailController,
                              cursorColor: Colors.black,
                              textInputAction: TextInputAction.next,
                              decoration:
                                  const InputDecoration(labelText: 'Email'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.all(16),
                            child: TextField(
                              controller: passwordController,
                              cursorColor: Colors.black,
                              textInputAction: TextInputAction.next,
                              decoration:
                                  const InputDecoration(labelText: 'Senha'),
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 40),
                        ])),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      icon: const Icon(Icons.lock_open, size: 32),
                      label: const Text(
                        'Entrar',
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: signIn,
                    ),
                  ]),
            )));
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

class LoginPage extends StatelessWidget {
  static const routeName = '/loginpage';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Deu algo errado!'));
              } else if (snapshot.hasData) {
                return HomePage(barracas: fetchBarracas());
              } else {
                return const LoginWidget();
              }
            }),
      );
}
