import 'package:flutter/material.dart';
import 'package:flutter_project/pages/add_barraca_page.dart';
import 'package:flutter_project/db/Database.dart';
import 'package:flutter_project/models/barraca.dart';
import 'package:flutter_project/pages/home_page.dart';
import 'package:flutter_project/pages/detail_page.dart';
import 'package:flutter_project/pages/login_page.dart';
import 'package:flutter_project/models/usuario.dart';
import 'package:flutter_project/pages/my_barraca_page.dart';
import 'package:flutter_project/providers/userProvider.dart';
import 'package:flutter_project/style/palette.dart';
import 'package:flutter_project/pages/review_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project/pages/cadastro_page.dart';
import 'package:provider/provider.dart';
import 'firebaseSettings/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => usuarioAtual(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Barraquinhas PUC',
        theme: ThemeData(
            primarySwatch:
                createMaterialColor(const Color.fromARGB(222, 250, 250, 250)),
            textTheme:
                const TextTheme(headline1: TextStyle(fontFamily: 'Poppins'))),
        home: HomePage(barracas: fetchBarracas()),
        routes: <String, WidgetBuilder>{
          DetailPage.routeName: (context) => const DetailPage(),
          ReviewPage.routeName: (context) => const ReviewPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          LoginPage.routeName: (context) => const LoginPage(),
          AddBarracaPage.routeName: (context) => const AddBarracaPage(),
          MyBarracaPage.routeName: (context) => const MyBarracaPage(),
        });
  }
}
