import 'package:flutter/material.dart';
import 'package:lavagem_app/data/repository/user_repository.dart';
import 'package:lavagem_app/data/service/get_it/init_getit.dart';
import 'package:lavagem_app/models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  
  UserViewModel({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<void> resetarSenha(String email) async {
    await _userRepository.resetarSenha(email);
  }

  Future<void> cadastrarUsuario(UserModel usuario) async {
    await _userRepository.cadastrar(usuario);
  }

  Future<void> login(String email, String senha) async {
    await _userRepository.login(email,senha);
  }

  Future<void> verificaSeExisteUsuario() async {
    await _userRepository.verificaSeExisteUsuario();
  }
}
