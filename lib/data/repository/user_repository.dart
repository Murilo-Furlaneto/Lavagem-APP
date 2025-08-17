import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lavagem_app/data/service/firebase/user_service.dart';
import 'package:lavagem_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final UserService _userService;
  static final String _keyUsuarioLogado = dotenv.get('USUARIO_LOGADO_KEY');

  UserRepository({required UserService userService}) : _userService = userService;

  Future<void> resetarSenha(String email) async {
    await _userService.resetarSenha(email);
  }

  Future<void> cadastrar(UserModel usuario) async {
    await _userService.cadastrar(usuario);
  }

  Future<void> verificarEmail(String email) async {
    await _userService.verificarEmail(email);
  }

  Future<void> login(String email, String senha) async {
    await _userService.login(email, senha);
  }

  Future<void> logOut() async {
    await _userService.logOut();
  }

  Future<void> verificaSeExisteUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final usuarioLogado = prefs.getString(_keyUsuarioLogado);
    if (usuarioLogado != null) {
      final userModel = UserModel.fromJson(usuarioLogado);
      log("Usuário logado: ${userModel.nome}");
    } else {
      log("Nenhum usuário logado.");
    }
  }
}
