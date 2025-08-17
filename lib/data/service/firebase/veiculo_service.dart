import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lavagem_app/data/service/get_it/init_getit.dart';
import 'package:lavagem_app/errors/failure.dart';
import 'package:lavagem_app/models/veiculo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VeiculoService {
  static final String _keyVeiculosFinalizados =
      dotenv.get('VEICULOS_FINALIZADOS_KEY');

  Future<Either<Failure, List<Veiculo>>> retornaListaVeiculos() async {
    try {
      var lista = getIt<FirebaseFirestore>().collection("veiculos");
      var snapshot = await lista.get();
      var veiculos = snapshot.docs.map((doc) {
        return Veiculo.fromJson(doc.data());
      }).toList();
      return right(veiculos);
    } catch (e, stackTrace) {
      log("Erro ao retornar lista de veículos.",
          name: "VeiculoService", error: e, stackTrace: stackTrace);
      return left(Failure("Erro ao retornar lista de veículos: $e"));
    }
  }

  Future<Either<Failure, Unit>> deletarVeiculos(String id) async {
    try {
      await getIt<FirebaseFirestore>().collection("veiculos").doc(id).delete();
      return right(unit);
    } catch (e, stackTrace) {
      log("Erro ao deletar veículo.",
          name: "VeiculoService", error: e, stackTrace: stackTrace);
      return left(Failure("Erro ao deletar veículo: $e"));
    }
  }

  Future<Either<Failure, List<Veiculo>>> retornaVeiculosFinalizados() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final veiculosFinalizados =
          prefs.getStringList(_keyVeiculosFinalizados) ?? [];

      var lista = getIt<FirebaseFirestore>().collection("veiculos");
      var snapshot = await lista.get();
      var veiculos = snapshot.docs.map((doc) {
        return Veiculo.fromJson(doc.data());
      }).toList();

      List<Veiculo> veiculosFiltrados = veiculos
          .where((veiculo) => veiculosFinalizados.contains(veiculo.id))
          .toList();

      return right(veiculosFiltrados);
    } catch (e, stackTrace) {
      log("Erro ao retornar veículos finalizados.",
          name: "VeiculoService", error: e, stackTrace: stackTrace);
      return left(Failure("Erro ao retornar veículos finalizados: $e"));
    }
  }
}
