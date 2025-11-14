import 'package:lavagem_app/data/service/firebase/user_service.dart';
import 'package:lavagem_app/domain/models/user_model.dart';

class UserRemoteDataSource {
  final UserService _userService;

  UserRemoteDataSource(UserService userService) : _userService = userService;

  Future<void> resetarSenha(String email) async {
    await _userService.resetarSenha(email);
  }

  Future<void> cadastrarUsuario(UserModel usuario) async {
    await _userService.cadastrar(usuario);
  }

  Future<void> login(String email, String senha) async {
    await _userService.login(email, senha);
  }

  Future<void> logOut() async {
    await _userService.logOut();
  }

  Future<void> cadastrar(UserModel usuario) async {
    await _userService.cadastrar(usuario);
  }

  Future<void> verificarEmail(String email) async {
    await _userService.verificarEmail(email);
  }
}
