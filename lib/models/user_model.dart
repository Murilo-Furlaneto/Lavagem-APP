import 'dart:convert';

class UserModel {
  final String nome;
  final String email;
  final String senha;
  final bool isConsultor;

  UserModel({
    required this.nome,
    required this.email,
    required this.senha,
    required this.isConsultor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'email': email,
      'senha': senha,
      'consultor': isConsultor,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nome: map['nome'] as String,
      email: map['email'] as String,
      senha: map['senha'] as String,
      isConsultor: map['consultor'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(nome: $nome, email: $email, senha: $senha, consultor: $isConsultor)';
  }
}
