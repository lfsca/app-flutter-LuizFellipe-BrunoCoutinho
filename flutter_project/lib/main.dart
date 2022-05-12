import 'package:flutter/material.dart';
import 'package:flutter_project/barraca.dart';
import 'package:flutter_project/homepage.dart';
import 'package:flutter_project/detailpage.dart';
import 'package:flutter_project/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Barraquinhas PUC',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch:
                createMaterialColor(Color.fromARGB(255, 253, 202, 168)),
            textTheme:
                const TextTheme(headline1: TextStyle(fontFamily: 'Poppins'))),
        home: HomePage(barracas: fetchBarracas()),
        routes: <String, WidgetBuilder>{
          DetailPage.routeName: (context) => const DetailPage(),
        });
  }
}
