
import 'package:lavagem_app/data/helper/database/user_database_helper.dart';
import 'package:lavagem_app/domain/models/user_model.dart';

class UserLocalDataSource {
   final UserDatabaseHelper _userDatabaseHelper;

   UserLocalDataSource(UserDatabaseHelper userDatabaseHelper)
       : _userDatabaseHelper = userDatabaseHelper;


   Future<void> salvarUsuario(UserModel usuario) async {
    await _userDatabaseHelper.saveUser(usuario);
   }

   Future<UserModel?> obterUsuario() async {
     return await _userDatabaseHelper.getUser();
   }

   Future<void> deletarUsuario() async {
     await _userDatabaseHelper.deleteUser();
   }

}