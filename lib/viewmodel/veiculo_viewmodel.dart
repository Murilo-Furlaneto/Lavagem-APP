import 'package:flutter/foundation.dart';
import 'package:lavagem_app/data/repository/veiculo_repository.dart';
import 'package:lavagem_app/models/veiculo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VeiculoViewModel extends ChangeNotifier {
  final VeiculoRepository _repository;

  VeiculoViewModel(this._repository);

  final ValueNotifier<Veiculo?> veiculoNotifier = ValueNotifier(null);

  Stream<QuerySnapshot> getVeiculosStream() {
    return _repository.getVeiculosStream();
  }

  Future<void> deletarVeiculo(String id) async {
    await _repository.deletarVeiculo(id);
    notifyListeners();
  }

  Future<void> cadastrarVeiculo(Veiculo veiculo) async {
    await _repository.cadastrarVeiculo(veiculo);
    notifyListeners();
  }

  Future<void> editarVeiculo(Veiculo veiculo) async {
    await _repository.editarVeiculo(veiculo);
    veiculoNotifier.value = veiculo; 
    notifyListeners();
  }

  Future<void> atualizarStatus(String veiculoId, String novoStatus) async {
    await _repository.atualizarStatus(veiculoId, novoStatus);
    notifyListeners();
  }

  void selecionarVeiculo(Veiculo? veiculo) {
    veiculoNotifier.value = veiculo;
  }
}
