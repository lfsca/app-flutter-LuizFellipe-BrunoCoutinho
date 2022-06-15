import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String id;
  final String nome;
  final String email;
  final bool vendedor;
  final bool administrador;

  const Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.vendedor,
    required this.administrador,
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

  @override
  String toString() {
    return 'Usuario {id: $id, nome: $nome, email: $email, vendedor: $vendedor, administrador: $administrador}';
  }

  static Usuario fromJson(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        nome: json['nome'],
        email: json['email'],
        vendedor: json['vendedor'],
        administrador: json['administrador'],
      );
}

Future<Usuario?> readUser(uid) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    return Usuario.fromJson(snapshot.data()!);
  }
}

Future<void> insertUsuario(Usuario usuario) async {
  final database =
      openDatabase(join(await getDatabasesPath(), 'HoraDoRango.db'));
  final db = await database;

  await db.insert(
    'usuarios',
    usuario.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
