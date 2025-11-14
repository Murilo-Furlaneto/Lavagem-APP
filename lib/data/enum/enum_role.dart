enum UserRole {
  consultor,
  lavador,
}

UserRole? retornaFuncaoUsario(String funcao) {
  try {
    return UserRole.values.firstWhere(
      (e) => e.name == funcao.toLowerCase(),
      orElse: () => throw ArgumentError('Função inválida: $funcao'),
    );
  } catch (e) {
    print(e);
    return null;
  }
}