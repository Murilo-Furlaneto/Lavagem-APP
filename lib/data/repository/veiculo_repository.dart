import 'package:lavagem_app/data/service/firebase/veiculo_service.dart';

class VeiculoRepository {
  final VeiculoService _veiculoService;
  VeiculoRepository(this._veiculoService);

  Future<void> retornaListaVeiculos() async {
    await _veiculoService.retornaListaVeiculos();
  }

  Future<void> deletarVeiculos(String id) async {
    await _veiculoService.deletarVeiculos(id);
  }

  Future<void> retornaVeiculosFinalizados() async {
    await _veiculoService.retornaVeiculosFinalizados();
  }
}
