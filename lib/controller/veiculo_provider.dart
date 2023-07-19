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

    if (novoStatus != Status.finalizado) {
      final prefs = await SharedPreferences.getInstance();
      final veiculosFinalizados = prefs.getStringList('veiculos_finalizados') ?? [];

      if (veiculosFinalizados.contains(veiculoId)) {
        veiculosFinalizados.remove(veiculoId);
        await prefs.setStringList('veiculos_finalizados', veiculosFinalizados);
      }
    }
  }

}
