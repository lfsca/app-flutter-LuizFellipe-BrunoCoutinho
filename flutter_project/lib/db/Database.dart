import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();
}

Future<Database> initDB() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, 'HoraDoRango.db');
  return await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (Database db, int version) async {
    await db.execute("CREATE TABLE Usuario ("
        "id INTEGER PRIMARY KEY,"
        "nome TEXT,"
        "email TEXT,"
        "vendedor BIT,"
        "administrador BIT"
        ")");
  });
}