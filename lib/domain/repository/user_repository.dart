import 'package:lavagem_app/domain/models/user_model.dart';

abstract class UserRepository {
  Future<void> resetarSenha(String email);
  Future<void> cadastrar(UserModel usuario);
  Future<void> login(String email, String senha);
  Future<void> logOut();
  Future<bool> verificaSeExisteUsuario();
  Future<UserModel?> obterUsuario();
  Future<void> salvarUsuario(UserModel usuario);

}