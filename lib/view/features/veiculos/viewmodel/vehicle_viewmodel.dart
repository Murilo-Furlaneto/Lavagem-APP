import 'package:flutter/foundation.dart';
import 'package:lavagem_app/domain/models/veiculo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lavagem_app/domain/repository/vehicle_repository.dart';

class VehicleViewModel extends ChangeNotifier {
  final VehicleRepository repository;

  VehicleViewModel(this.repository);

  final ValueNotifier<Veiculo?> veiculoNotifier = ValueNotifier(null);

  Stream<QuerySnapshot> retornarVeiculosStream() {
    return repository.retornarVeiculosStream();
  }

  Future<void> deletarVeiculo(String id) async {
    await repository.deletarVeiculo(id);
    notifyListeners();
  }

  Future<void> cadastrarVeiculo(Veiculo veiculo) async {
    await repository.cadastrarVeiculo(veiculo);
    notifyListeners();
  }

  Future<void> editarVeiculo(Veiculo veiculo) async {
    await repository.editarVeiculo(veiculo);
    veiculoNotifier.value = veiculo; 
    notifyListeners();
  }

  Future<void> atualizarStatus(String veiculoId, String novoStatus) async {
    await repository.atualizarStatus(veiculoId, novoStatus);
    notifyListeners();
  }

  void selecionarVeiculo(Veiculo? veiculo) {
    veiculoNotifier.value = veiculo;
  }
}
