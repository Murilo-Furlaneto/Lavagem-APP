import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/veiculo_model.dart';

class VeiculoProvider with ChangeNotifier {
  late VeiculoModel _veiculoModel;

  VeiculoModel get veiculoModel => _veiculoModel;

  set veiculoModel(VeiculoModel veiculoModel) {
    _veiculoModel = veiculoModel;
    notifyListeners();
  }

  void setStatus(Status novoStatus, String veiculoId) async {
    final prefs = await SharedPreferences.getInstance();
    final veiculosFinalizados = prefs.getStringList('veiculos_finalizados') ?? [];

    if (novoStatus == Status.finalizado) {
      // Se o novo status for 'finalizado', adicione o veículo à lista de "veiculos_finalizados"
      if (!veiculosFinalizados.contains(veiculoId)) {
        veiculosFinalizados.add(veiculoId);
        await prefs.setStringList('veiculos_finalizados', veiculosFinalizados);
      }
    } else {
      // Se o novo status não for 'finalizado', verifique se o veículo está na lista de "veiculos_finalizados"
      if (veiculosFinalizados.contains(veiculoId)) {
        veiculosFinalizados.remove(veiculoId);
        await prefs.setStringList('veiculos_finalizados', veiculosFinalizados);
      }
    }
  }
}
