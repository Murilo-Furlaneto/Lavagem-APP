import 'package:flutter/material.dart';

enum Status {
  cadastrado,
  lavando,
  finalizado,
}

extension StatusExtension on Status {
  Color get color {
    switch (this) {
      case Status.cadastrado:
        return const Color(0xff717C89);
      case Status.lavando:
        return const Color(0xffE3DBDB);
      case Status.finalizado:
        return const Color(0xff90BAAD);
      default:
        return Colors.white;
    }
  }
}

class VeiculoModel {
  final String id;
  final String modelo;
  final String placa;
  final String cor;
  final Status status;
  final String? observacao;
  VeiculoModel({
    required this.id,
    required this.modelo,
    required this.placa,
    required this.cor,
    required this.status,
    this.observacao,
  });
}
