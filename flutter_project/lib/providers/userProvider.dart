import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../db/Database.dart';
import '../models/usuario.dart';

class usuarioAtual extends ChangeNotifier {
  Future<Usuario> checarUsuario() async {
    Usuario usuarioLido;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      usuarioLido = await DBProvider.db.lerUsuario(user.uid);
    } else {
      usuarioLido = "" as Usuario;
    }
    notifyListeners();
    return usuarioLido;
  }
}
