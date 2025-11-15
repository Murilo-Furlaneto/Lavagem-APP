import 'package:flutter/material.dart';
import 'package:lavagem_app/core/theme/theme.dart';
import 'package:lavagem_app/data/service/notification/notification_service.dart';
import 'package:lavagem_app/domain/models/veiculo_model.dart';
import 'package:lavagem_app/view/features/veiculos/pages/veiculos_form_page.dart';
import 'package:lavagem_app/view/features/veiculos/viewmodel/vehicle_viewmodel.dart';

class VeiculoCard extends StatelessWidget {
  const VeiculoCard({super.key, 
    required this.veiculo,
    required this.veiculoViewModel,
    required this.notificationService,
    required this.isConsultor,
    required this.onError,
  });

  final Veiculo veiculo;
  final VehicleViewModel veiculoViewModel;
  final NotificationService notificationService;
  final bool isConsultor;
  final void Function(String) onError;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: veiculo.status.color,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.directions_car, size: 40),
        title: Text(
          veiculo.modelo.toUpperCase(),
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Placa: ${veiculo.placa.toUpperCase()}',
          style: const TextStyle(fontSize: 15),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VeiculosFormPage(veiculoModel: veiculo),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                if (isConsultor) {
                  veiculoViewModel.deletarVeiculo(veiculo.id);
                  await notificationService
                      .removerVeiculoFinalizado(veiculo.placa);
                } else {
                  onError('Você não tem acesso a essa funcionalidade.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

