import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? id;
  String nome;
  String? email;
  bool? vendedor;
  bool? administrador;

  Usuario({
    this.id,
    this.nome = "",
    this.email,
    this.vendedor = false,
    this.administrador = false,
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

  static Future addUser(uid, String nome, String email, bool vendedor) async {
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

  factory Usuario.fromFirestore(Map<String, dynamic>? data, String uid) {
    return Usuario(
      id: uid,
      nome: data?['nome'],
      email: data?['email'],
      vendedor: data?['vendedor'],
      administrador: data?['administrador'],
    );
  }

  static Usuario fromJson(Map<String, dynamic> json) => Usuario(
        id: "1", //json['documentID'],
        nome: json['nome'],
        email: json['email'],
        //vendedor: json['vendedor'],
        //administrador: json['administrador'],
      );
}

Future<Usuario?> readUser(uid) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    return Usuario.fromJson(snapshot.data()!);
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
