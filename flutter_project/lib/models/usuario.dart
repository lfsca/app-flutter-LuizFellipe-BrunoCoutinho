import 'package:flutter_project/db/Database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? id;
  String nome;
  String? email;
  String? vendedor;
  String? administrador;

  Usuario({
    this.id,
    this.nome = "",
    this.email,
    this.vendedor,
    this.administrador,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'vendedor': vendedor,
      'administrador': administrador,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json, String uid) => Usuario(
        id: uid,
        nome: json['nome'],
        email: json['email'],
        vendedor: json['vendedor'],
        administrador: json['administrador'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "email": email,
        "vendedor": vendedor,
        "administrador": administrador,
      };

  @override
  String toString() {
    return 'Usuario {id: $id, nome: $nome, email: $email, vendedor: $vendedor, administrador: $administrador}';
  }

  static Future addUser(uid, String nome, String email, bool vendedor) async {
    final usuario = FirebaseFirestore.instance.collection('usuario').doc(uid);
    // Call the user's CollectionReference to add a new user
    String vendedorString = "0";
    if (vendedor == true) {
      vendedorString = "1";
    }
    try {
      final json = {
        'nome': nome,
        'email': email,
        'vendedor': vendedorString,
        'administrador': "0",
      };
      await usuario.set(json);
    } catch (error) {
      print("Falha ao criar usuario: $error");
    }
    print("Usuario Criado!");
  }

  factory Usuario.fromFirestore(Map<String, dynamic>? data, String uid) {
    return Usuario(
      id: uid,
      nome: data?['nome'],
      email: data?['email'],
      vendedor: data?['vendedor'],
      administrador: data?['administrador'],
    );
  }

  factory Usuario.fromMap(Map<String, dynamic> json, String uid) => Usuario(
        id: uid,
        nome: json['nome'],
        email: json['email'],
        vendedor: json['vendedor'],
        administrador: json['administrador'],
      );
}

Future<Usuario> readUser(uid) async {
  final docUser = FirebaseFirestore.instance.collection('usuario').doc(uid);
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    print("READ USER1");
    print(snapshot.data);
    print(Usuario.fromJson(snapshot.data()!, uid));
    print("READ USER2");
    return Usuario.fromJson(snapshot.data()!, uid);
  }
  return Usuario();
}

Future<void> parseUser(uid) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
  final snapshot = await docUser.get();
  final database =
      openDatabase(join(await getDatabasesPath(), 'HoraDoRango.db'));
  final db = await database;
  Usuario? novoUsuario;

  if (snapshot.exists) {
    novoUsuario = Usuario.fromJson(snapshot.data()!, uid);
  }
  if (novoUsuario != null) {
    await db.insert(
      'usuario',
      novoUsuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

Future<List<Usuario>> fetchVendedores() async {
  List<Usuario> list = [];
  await FirebaseFirestore.instance
      .collection('usuario')
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['vendedor'] == true)
        list.add(Usuario.fromFirestore(data, doc.id));
    }
  });
  return list;
}
