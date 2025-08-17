import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lavagem_app/data/enum/enum_status.dart';
import 'package:lavagem_app/data/service/notification/notification_service.dart';
import 'package:lavagem_app/widgets/message_firebase_widget.dart';
import '../../models/veiculo_model.dart';
import '../veiculos/veiculos_form_page.dart';
import 'package:lavagem_app/controller/veiculo_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.nome, required this.consultor});

  final String nome;
  final bool consultor;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showContent = false;
  final _notificationService = NotificationService();
  final _veiculoController = VeiculoController();

  @override
  void initState() {
    boasVindas();
    super.initState();
    _veiculoController.verificarVeiculosFinalizados();
  }

  Future boasVindas() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showContent = true;
      });
    });
  }

  Status getStatusFromString(String statusString) {
    switch (statusString) {
      case 'cadastrado':
        return Status.cadastrado;
      case 'lavando':
        return Status.lavando;
      case 'finalizado':
        return Status.finalizado;
      default:
        return Status.cadastrado;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.blue[500],
        title: showContent
            ? Row(
                children: [
                  const Icon(Icons.person),
                  const SizedBox(width: 5),
                  Text(
                    'Olá, ${widget.nome}',
                    style: const TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (widget.consultor == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FormPage()));
                      } else {
                        SnackBarUtil.showError(context,
                            'Você não tem acesso a essa funcionalidade.');
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _service.logOut(context: context);
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            : null,
      ),
      body: showContent
          ? StreamBuilder(
              stream: _service.retornaListaVeiculos(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var snap = snapshot.data!.docs;
                      VeiculoModel veiculoModel = VeiculoModel(
                          id: snap[index].id,
                          modelo: snap[index]['modelo'],
                          placa: snap[index]['placa'],
                          cor: snap[index]['cor'],
                          status: getStatusFromString(
                              snap[index]['status'] ?? 'cadastrando'),
                          observacao: snap[index]['observacao']);

                      _notificationService.verificarFinalizado(veiculoModel);
                      return Card(
                        color: veiculoModel.status.color,
                        child: ListTile(
                          leading: const Icon(Icons.directions_car),
                          title: Text(
                            veiculoModel.modelo.toUpperCase(),
                            style: const TextStyle(fontSize: 17),
                          ),
                          subtitle: Text(
                            'Placa: ${veiculoModel.placa.toUpperCase()}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FormPage(
                                                    veiculoModel: veiculoModel,
                                                  )));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    )),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    if (widget.consultor == true) {
                                      _service.deletarVeiculos(veiculoModel.id);
                                      await _notificationService
                                          .removerVeiculoFinalizado(
                                              veiculoModel.placa);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Você não tem acesso a essa funcionalidade.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : Center(
              child: Center(
                child: Text('Bem-vindo ${widget.nome}',
                    style: const TextStyle(fontSize: 20)),
              ),
            ),
    );
  }
}
