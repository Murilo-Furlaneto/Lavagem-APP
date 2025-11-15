import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lavagem_app/domain/models/veiculo_model.dart';

abstract class VehicleRepository {
  Future<void> deletarVeiculo(String id);
  Future<void> cadastrarVeiculo(Veiculo veiculo);
  Future<void> editarVeiculo(Veiculo veiculo);
  Future<void> atualizarStatus(String veiculoId, String novoStatus);
  Future<bool> verificarVeiculoFinalizado(String veiculoId);
  Future<List<Veiculo>> retornarVeiculosFinalizados();
  Stream<QuerySnapshot<Object?>> retornarVeiculosStream();
}


