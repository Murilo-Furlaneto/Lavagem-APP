import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lavagem_app/data/enum/enum_status.dart';
import 'package:lavagem_app/data/service/notification/notification_service.dart';
import 'package:lavagem_app/domain/models/veiculo_model.dart';
import 'package:lavagem_app/view/features/veiculos/pages/veiculos_form_page.dart';
import 'package:lavagem_app/view/features/auth/view_model/user_viewmodel.dart';
import 'package:lavagem_app/view/features/veiculos/viewmodel/vehicle_viewmodel.dart';
import 'package:lavagem_app/view/features/veiculos/pages/widgets/veiculo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.veiculoViewModel,
    required this.userViewModel,
  });

  final VehicleViewModel veiculoViewModel;
  final UserViewModel userViewModel;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _notificationService = NotificationService();

  Status _getStatusFromString(String statusString) {
    return Status.values.firstWhere(
      (e) => e.toString().split('.').last == statusString,
      orElse: () => Status.cadastrado,
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void initState() {
    widget.userViewModel.obterUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: widget.userViewModel.usuarioNotifier,
          builder: (_, usuario, child) {
            return Text('Bem-vindo, ${usuario!.nome}');
          },
        ),
        backgroundColor: Colors.blue[500],
        actions: [
          ValueListenableBuilder(
            valueListenable: widget.userViewModel.usuarioNotifier,
            builder: (_, usuario, child) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (usuario!.funcao.index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VeiculosFormPage()),
                        );
                      } else {
                        _showErrorSnackbar(
                            'Você não tem acesso a essa funcionalidade.');
                      }
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    tooltip: 'Adicionar Veículo',
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Implementar a funcionalidade de logout
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    tooltip: 'Sair',
                  ),
                ],
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: widget.veiculoViewModel.retornarVeiculosStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os dados.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum veículo cadastrado.'));
          }

          final veiculos = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Veiculo(
              id: doc.id,
              modelo: data['modelo'] ?? '',
              placa: data['placa'] ?? '',
              cor: data['cor'] ?? '',
              status: _getStatusFromString(data['status'] ?? 'cadastrado'),
              observacao: data['observacao'] ?? '',
            );
          }).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: veiculos.length,
            itemBuilder: (context, index) {
              final veiculo = veiculos[index];
              _notificationService.verificarFinalizado(veiculo);
              return VeiculoCard(
                veiculo: veiculo,
                veiculoViewModel: widget.veiculoViewModel,
                notificationService: _notificationService,
                isConsultor: widget.userViewModel.usuarioNotifier.value!.funcao.index == 0,
                onError: _showErrorSnackbar,
              );
            },
          );
        },
      ),
    );
  }
}


