import 'package:lavagem_app/data/database/app_database.dart';
import 'package:lavagem_app/data/enum/enum_role.dart';
import 'package:lavagem_app/domain/models/user_model.dart';

class UserDatabaseHelper {
  final AppDatabase _appDatabase;

  UserDatabaseHelper(AppDatabase appDatabase) : _appDatabase = appDatabase;

  Future<void> saveUser(UserModel user) async {
    await _appDatabase.into(_appDatabase.users).insert(user.toCompanion());
  }

  Future<UserModel?> getUser() async {
    return await _appDatabase
        .select(_appDatabase.users)
        .getSingleOrNull()
        .then((value) {
      if (value != null) {
      final funcao =  retornaFuncaoUsario(value.funcao);
        return UserModel(nome: value.nome, email: value.email, senha: "", funcao:funcao ?? UserRole.lavador);
      } else {
        return null;
      }
    });
  }

  Future<void> deleteUser() async {
    await _appDatabase.delete(_appDatabase.users).go();
  }
}
