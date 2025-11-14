import 'package:lavagem_app/domain/models/user_model.dart';

class UserValidation {
  static String? validar(UserModel user) {
    if (user.nome.isEmpty) {
      return 'O nome não pode estar vazio.';
    } else if (user.nome.length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres.';
    } else if (RegExp(r'[0-9]').hasMatch(user.nome)) {
      return 'O nome não pode conter números.';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%.,-]').hasMatch(user.nome)) {
      return 'O nome não pode conter caracteres especiais.';
    }
    
    final emailError = validarEmail(user.email);
    if (emailError != null) {
      return emailError;
    }

    final passwordError = validarSenha(user.senha);
    if (passwordError != null) {
      return passwordError;
    }

    return null; 
  }

  static String? validarEmail(String email) {
    if (email.isEmpty) {
      return 'O email não pode estar vazio.';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Formato de email inválido.';
    }
    return null; 
  }

  static String? validarSenha(String password) {
    if (password.isEmpty) {
      return 'A senha não pode estar vazia.';
    } else if (password.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'A senha deve conter pelo menos uma letra maiúscula.';
    } else if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'A senha deve conter pelo menos uma letra minúscula.';
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'A senha deve conter pelo menos um número.';
    } else if (!RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%.,-]').hasMatch(password)) {
      return 'A senha deve conter pelo menos um caractere especial.';
    }
    return null;
  }
}
