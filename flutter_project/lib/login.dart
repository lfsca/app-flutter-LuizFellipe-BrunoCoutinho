import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_email/main.dart';
// import 'package:firebase_auth_email/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/homepage.dart';
import 'package:flutter_project/barraca.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class LoginWidget extends StatefulWidget {
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
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 40),
        Container(
          child: TextField(
            controller: emailController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Email'),
          ),
        ),
        SizedBox(height: 4),
        TextField(
          controller: passwordController,
          cursorColor: Colors.black,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: 'Senha'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
          ),
          icon: Icon(Icons.lock_open, size: 32),
          label: Text(
            'Entrar',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: signIn,
        ),
      ]));

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

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

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Deu algo errado!'));
              } else if (snapshot.hasData) {
                return HomePage(barracas: fetchBarracas());
              } else {
                return LoginWidget();
              }
            }),
      );
}
