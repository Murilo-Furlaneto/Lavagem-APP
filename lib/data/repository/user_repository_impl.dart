import 'dart:developer';

import 'package:lavagem_app/data/datasource/local/user_local_data_source.dart';
import 'package:lavagem_app/data/datasource/remote/user_remote_data_source.dart';
import 'package:lavagem_app/domain/models/user_model.dart';
import 'package:lavagem_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  UserRepositoryImpl(UserRemoteDataSource userRemoteDataSource,
      UserLocalDataSource userLocalDataSource)
      : _userRemoteDataSource = userRemoteDataSource,
        _userLocalDataSource = userLocalDataSource;

  @override
  Future<void> resetarSenha(String email) async {
    await _userRemoteDataSource.resetarSenha(email);
  }

  @override
  Future<void> cadastrar(UserModel usuario) async {
    await _userRemoteDataSource.cadastrar(usuario);
  }

  Future<void> verificarEmail(String email) async {
    await _userRemoteDataSource.verificarEmail(email);
  }

  @override
  Future<void> login(String email, String senha) async {
    await _userRemoteDataSource.login(email, senha);
  }

  @override
  Future<void> logOut() async {
    await _userRemoteDataSource.logOut();
  }

  @override
  Future<bool> verificaSeExisteUsuario() async {
    final usuarioLogado = await _userLocalDataSource.obterUsuario();
    if (usuarioLogado != null) {
      log("Usuário logado: ${usuarioLogado.nome}");
      return true;
    } else {
      log("Nenhum usuário logado.");
      return false;
    }
  }

  @override
  Future<UserModel?> obterUsuario() async {
    final usuarioLogado = _userLocalDataSource.obterUsuario();
    return usuarioLogado;
  }

  @override
  Future<void> salvarUsuario(UserModel usuario) async {
    await _userLocalDataSource.salvarUsuario(usuario);
  }
}
