import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lavagem_app/data/datasource/remote/vehicle_remote_data_source.dart';
import 'package:lavagem_app/domain/models/veiculo_model.dart';
import 'package:lavagem_app/domain/repository/vehicle_repository.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDataSource remoteDataSource;

  VehicleRepositoryImpl(this.remoteDataSource);

  @override
  Stream<QuerySnapshot> retornarVeiculosStream()  {
    return remoteDataSource.retornarVeiculosStream();
  }

  @override
  Future<void> deletarVeiculo(String id) async {
    await remoteDataSource.deletarVeiculo(id);
  }

  @override
  Future<void> cadastrarVeiculo(Veiculo veiculo) async {
    await remoteDataSource.cadastrarVeiculo(veiculo);
  }

  @override
  Future<void> editarVeiculo(Veiculo veiculo) async {
    await remoteDataSource.editarVeiculo(veiculo);
  }

  @override
  Future<void> atualizarStatus(String veiculoId, String novoStatus) async {
    await remoteDataSource.atualizarStatus(veiculoId, novoStatus);
  }

  @override
  Future<bool> verificarVeiculoFinalizado(String veiculoId) async {
    return await remoteDataSource.verificarVeiculoFinalizado(veiculoId);
  }

  @override
  Future<List<Veiculo>> retornarVeiculosFinalizados() async {
    return await remoteDataSource.retornarVeiculosFinalizados();
  }
  

}
