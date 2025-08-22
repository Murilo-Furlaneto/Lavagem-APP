import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lavagem_app/core/theme/error/app_error_manager.dart';
import 'package:lavagem_app/data/service/get_it/init_getit.dart';
import 'package:lavagem_app/models/veiculo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VeiculoService {
  static final String _keyVeiculosFinalizados =
      dotenv.get('VEICULOS_FINALIZADOS_KEY');
  final AppErrorManager _errorManager = AppErrorManager();

  Future<List<Veiculo>> retornaListaVeiculos() async {
    try {
      var lista = getIt<FirebaseFirestore>().collection("veiculos");
      var snapshot = await lista.get();
      var veiculos = snapshot.docs.map((doc) {
        return Veiculo.fromJson(doc.data());
      }).toList();
      return veiculos;
    } catch (e, stackTrace) {
      _errorManager.logFirebaseError(
        message: "Erro ao retornar a lista de veículos.",
        className: "VeiculoService",
        originalException: Exception("Erro ao retornar a lista de veículos: ${e.toString()}"),
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  Future<void> deletarVeiculos(String id) async {
    try {
      await getIt<FirebaseFirestore>().collection("veiculos").doc(id).delete();
      await _removerVeiculoFinalizado(id);
    } catch (e, stackTrace) {
      _errorManager.logFirebaseError(
        message: "Erro ao deletar veículo com ID: $id.",
        className: "VeiculoService",
        originalException: Exception("Erro ao deletar veículo: ${e.toString()}"),
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> cadastrarVeiculo(Veiculo veiculo) async {
    try {
      await getIt<FirebaseFirestore>().collection('veiculos').add(veiculo.toJson());
    } catch (e, stackTrace) {
      _errorManager.logFirebaseError(
        message: "Erro ao cadastrar veículo.",
        className: "VeiculoService",
        originalException: Exception("Erro ao cadastrar veículo: ${e.toString()}"),
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> editarVeiculo(Veiculo veiculo) async {
    try {
      await getIt<FirebaseFirestore>()
          .collection('veiculos')
          .doc(veiculo.id)
          .update(veiculo.toJson());
    } catch (e, stackTrace) {
      _errorManager.logFirebaseError(
        message: "Erro ao editar veículo com ID: ${veiculo.id}.",
        className: "VeiculoService",
        originalException: Exception("Erro ao editar veículo: ${e.toString()}"),
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> atualizarStatus(String veiculoId, String novoStatus) async {
    try {
      await getIt<FirebaseFirestore>()
          .collection('veiculos')
          .doc(veiculoId)
          .update({'status': novoStatus});

      if (novoStatus == 'finalizado') {
        final prefs = await SharedPreferences.getInstance();
        final veiculosFinalizados =
            prefs.getStringList(_keyVeiculosFinalizados) ?? [];
        if (!veiculosFinalizados.contains(veiculoId)) {
          veiculosFinalizados.add(veiculoId);
          await prefs.setStringList(_keyVeiculosFinalizados, veiculosFinalizados);
        }
      }
    } catch (e, stackTrace) {
      _errorManager.logFirebaseError(
        message: "Erro ao atualizar status do veículo.",
        className: "VeiculoService",
        originalException: Exception("Erro ao atualizar status: ${e.toString()}"),
        stackTrace: stackTrace,
      );
    }
  }

  Future<List<String>> getVeiculosFinalizados() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_keyVeiculosFinalizados) ?? [];
    } catch (e, stackTrace) {
      _errorManager.logFirebaseError(
        message: "Erro ao obter veículos finalizados.",
        className: "VeiculoService",
        originalException: Exception("Erro ao obter veículos finalizados: ${e.toString()}"),
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  Future<bool> isVeiculoFinalizado(String veiculoId) async {
    try {
      final veiculosFinalizados = await getVeiculosFinalizados();
      return veiculosFinalizados.contains(veiculoId);
    } catch (e, stackTrace) {
      _errorManager.logFirebaseError(
        message: "Erro ao verificar se veículo está finalizado.",
        className: "VeiculoService",
        originalException: Exception("Erro ao verificar veículo finalizado: ${e.toString()}"),
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<void> _removerVeiculoFinalizado(String veiculoId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final veiculosFinalizados =
          prefs.getStringList(_keyVeiculosFinalizados) ?? [];
      veiculosFinalizados.remove(veiculoId);
      await prefs.setStringList(_keyVeiculosFinalizados, veiculosFinalizados);
    } catch (e, stackTrace) {
      _errorManager.logFirebaseError(
        message: "Erro ao remover veículo finalizado.",
        className: "VeiculoService",
        originalException: Exception("Erro ao remover veículo finalizado: ${e.toString()}"),
        stackTrace: stackTrace,
      );
    }
  }

  Future<List<Veiculo>> retornaVeiculosFinalizados() async {
    try {
      final veiculosFinalizados = await getVeiculosFinalizados();

      var lista = getIt<FirebaseFirestore>().collection("veiculos");
      var snapshot = await lista.get();
      var veiculos = snapshot.docs.map((doc) {
        return Veiculo.fromJson(doc.data());
      }).toList();

      List<Veiculo> veiculosFiltrados = veiculos
          .where((veiculo) => veiculosFinalizados.contains(veiculo.id))
          .toList();

      return veiculosFiltrados;
    } catch (e, stackTrace) {
      _errorManager.logFirebaseError(
        message: "Erro ao retornar veículos finalizados.",
        className: "VeiculoService",
        originalException: Exception("Erro ao retornar veículos finalizados: ${e.toString()}"),
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  Stream<QuerySnapshot> getVeiculosStream() {
    try {
      return getIt<FirebaseFirestore>().collection("veiculos").snapshots();
    } catch (e, stackTrace) {
      _errorManager.logFirebaseError(
        message: "Erro ao obter stream de veículos.",
        className: "VeiculoService",
        originalException: Exception("Erro ao obter stream de veículos: ${e.toString()}"),
        stackTrace: stackTrace,
      );
      return const Stream.empty();
    }
  }
}