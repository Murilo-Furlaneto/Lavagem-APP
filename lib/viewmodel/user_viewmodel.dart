import 'package:flutter/material.dart';
import 'package:lavagem_app/domain/models/user_model.dart';
import 'package:lavagem_app/domain/repository/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  
  UserViewModel({required UserRepository userRepository})
      : _userRepository = userRepository;

  final ValueNotifier<UserModel?> usuarioNotifier = ValueNotifier(null);
   UserModel get usuario => usuarioNotifier.value!;

  Future<void> resetarSenha(String email) async {
    await _userRepository.resetarSenha(email);
  }

  Future<void> cadastrarUsuario(UserModel usuario) async {
    await _userRepository.cadastrar(usuario);
  }

  Future<void> login(String email, String senha) async {
    await _userRepository.login(email,senha);
  }

  Future<bool> verificaSeExisteUsuario() async {
    return await _userRepository.verificaSeExisteUsuario();
  }

  Future<UserModel?> obterUsuario() async {
    return await _userRepository.obterUsuario();
  }
}
