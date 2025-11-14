import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lavagem_app/data/enum/enum_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/models/veiculo_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void verificarFinalizado(Veiculo veiculoModel) async {
    if (veiculoModel.status == Status.finalizado) {
      final prefs = await SharedPreferences.getInstance();
      final veiculosFinalizados =
          prefs.getStringList('veiculos_finalizados') ?? [];

      if (!veiculosFinalizados.contains(veiculoModel.placa)) {
        showNotification(
          title: 'Veículo Pronto',
          body:
              'O veículo ${veiculoModel.modelo.toUpperCase()} está pronto para ser entregue!',
        );

        veiculosFinalizados.add(veiculoModel.placa);
        await prefs.setStringList('veiculos_finalizados', veiculosFinalizados);
      }
    }
  }

  Future<void> removerVeiculoFinalizado(String veiculoPlaca) async {
    final prefs = await SharedPreferences.getInstance();
    final veiculosFinalizados =
        prefs.getStringList('veiculos_finalizados') ?? [];
    veiculosFinalizados.remove(veiculoPlaca);
    await prefs.setStringList('veiculos_finalizados', veiculosFinalizados);
  }

  static void initialize(BuildContext context) {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id', // Id único do canal para Android.
      'channel_name', // Nome do canal para Android.
      importance: Importance.high,
      priority: Priority.high,
      icon: 'logo', // Ícone da notificação.
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0, // Id único para a notificação.
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
