import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_project/models/usuario.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    print("ENTREI NO INITDB");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'HoraDoRango.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      print("ENTREI NO ONCREATE");
      await db.execute("CREATE TABLE Usuario ("
          "id TEXT PRIMARY KEY,"
          "nome TEXT,"
          "email TEXT,"
          "vendedor TEXT,"
          "administrador TEXT"
          ")");
    });
  }

  Future close() async {
    final database = await db.database;
    database.close();
  }

  Future<void> insertUsuario(Usuario usuario) async {
    final banco = await db.database;
    await banco.insert(
      'Usuario',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Usuario> lerUsuario(uid) async {
    print("ENTROU NO LERRR");
    final banco = await db.database;

    var res = await banco.query('Usuario', where: "id = ?", whereArgs: [uid]);
    if (res.isNotEmpty) {
      return Usuario.fromMap(res.first, uid);
    } else {
      return Usuario();
    }
  }
}
