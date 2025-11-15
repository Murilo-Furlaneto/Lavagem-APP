import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lavagem_app/data/service/firebase/vehicle_service.dart';
import 'package:lavagem_app/domain/models/veiculo_model.dart';

class VehicleRemoteDataSource {
  final VehicleService _veiculoService;

  VehicleRemoteDataSource(VehicleService veiculoService)
      : _veiculoService = veiculoService;

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

  Future<List<Veiculo>> retornarListaVeiculos() async {
    return await _veiculoService.retornarVeiculosFinalizados();
  }

  Stream<QuerySnapshot> retornarVeiculosStream() {
    return _veiculoService.retornarVeiculosStream();
  }
 
  Future<bool> verificarVeiculoFinalizado(String veiculoId) async {
    return await _veiculoService.verificarVeiculoFinalizado(veiculoId);
  }

  Future<List<Veiculo>> retornarVeiculosFinalizados() async {
    return await _veiculoService.retornarVeiculosFinalizados();
  }

}
