import 'package:flutter/foundation.dart';
import 'package:lavagem_app/data/enum/enum_status.dart';
import 'package:shared_preferences/shared_preferences.dart';


class VeiculoViewModel extends ChangeNotifier {
  void atualizarStatus(Status novoStatus, String veiculoId) async {
    if (novoStatus == Status.finalizado) {
      final prefs = await SharedPreferences.getInstance();
      final veiculosFinalizados =
          prefs.getStringList('veiculos_finalizados') ?? [];

      if (!veiculosFinalizados.contains(veiculoId)) {
        veiculosFinalizados.add(veiculoId);
        await prefs.setStringList('veiculos_finalizados', veiculosFinalizados);
      }
    }
     notifyListeners();
  }

  Future<List<String>> getVeiculosFinalizados() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('veiculos_finalizados') ?? [];
  }

  Future<bool> isVeiculoFinalizado(String veiculoId) async {
    final veiculosFinalizados = await getVeiculosFinalizados();
    return veiculosFinalizados.contains(veiculoId);
  }
}
