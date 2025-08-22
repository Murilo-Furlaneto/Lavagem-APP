import 'package:flutter/material.dart';
import 'package:lavagem_app/data/repository/user_repository.dart';
import 'package:lavagem_app/data/service/get_it/init_getit.dart';
import 'package:lavagem_app/models/user_model.dart';

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

  Future<UserModel> obterUsuario() async {
    return await _userRepository.obterUsuario();
  }
}
