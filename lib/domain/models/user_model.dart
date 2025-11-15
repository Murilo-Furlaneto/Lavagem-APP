import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:lavagem_app/data/database/app_database.dart';
import 'package:lavagem_app/data/enum/enum_role.dart';

class UserModel {
  final String nome;
  final String email;
  final String senha;
  final UserRole funcao;

  UserModel({
    required this.nome,
    required this.email,
    required this.senha,
    required this.funcao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'email': email,
      'senha': senha,
      'funcao': funcao.toString(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nome: map['nome'] as String,
      email: map['email'] as String,
      senha: map['senha'] as String,
      funcao: UserRole.values.firstWhere((e) => e.toString() == map['funcao']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(nome: $nome, email: $email, senha: $senha, funcao: $funcao)';
  }

  UsersCompanion toCompanion() {
    return UsersCompanion(
      uid: const Value.absent(),
      nome: Value(nome),
      email: Value(email),
      funcao: Value(funcao.toString()),
      isLoggedIn: const Value.absent()
    );
  }
}
