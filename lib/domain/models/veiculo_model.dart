import 'package:lavagem_app/data/enum/enum_status.dart';

class Veiculo {
  final String id;
  final String modelo;
  final String placa;
  final String cor;
  final Status status;
  final String? observacao;
  Veiculo({
    required this.id,
    required this.modelo,
    required this.placa,
    required this.cor,
    required this.status,
    this.observacao,
  });

  factory Veiculo.fromJson(Map<String, dynamic> json) {
    return Veiculo(
      id: json['id'] as String,
      modelo: json['modelo'] as String,
      placa: json['placa'] as String,
      cor: json['cor'] as String,
      status: Status.values
          .firstWhere((e) => e.toString() == 'Status.${json['status']}'),
      observacao: json['observacao'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modelo': modelo,
      'placa': placa,
      'cor': cor,
      'status': status.toString().split('.').last,
      'observacao': observacao,
    };
  }
}
