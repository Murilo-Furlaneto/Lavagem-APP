import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lavagem_app/data/service/firebase/veiculo_service.dart';
import 'package:lavagem_app/models/veiculo_model.dart';

class VeiculoRepository {
  final VeiculoService _veiculoService;

  VeiculoRepository(this._veiculoService);

  Stream<QuerySnapshot> getVeiculosStream() {
    return _veiculoService.getVeiculosStream();
  }

  Future<void> deletarVeiculo(String id) async {
    await _veiculoService.deletarVeiculos(id);
  }

  Future<void> cadastrarVeiculo(Veiculo veiculo) async {
    await _veiculoService.cadastrarVeiculo(veiculo);
  }

  Future<void> editarVeiculo(Veiculo veiculo) async {
    await _veiculoService.editarVeiculo(veiculo);
  }

  Future<void> atualizarStatus(String veiculoId, String novoStatus) async {
    await _veiculoService.atualizarStatus(veiculoId, novoStatus);
  }

  Future<List<String>> getVeiculosFinalizados() async {
    return await _veiculoService.getVeiculosFinalizados();
  }

  Future<bool> isVeiculoFinalizado(String veiculoId) async {
    return await _veiculoService.isVeiculoFinalizado(veiculoId);
  }

  Future<List<Veiculo>> retornaVeiculosFinalizados() async {
    return await _veiculoService.retornaVeiculosFinalizados();
  }
}