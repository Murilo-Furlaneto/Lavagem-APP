import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lavagem_app/models/veiculo_model.dart';

class VeiculosFormPage extends StatefulWidget {
  const VeiculosFormPage({super.key, this.veiculoModel});

  final VeiculoModel? veiculoModel;

  @override
  State<VeiculosFormPage> createState() => VeiculosFormPageState();
}

class VeiculosFormPageState extends State<VeiculosFormPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  final _firebaseStore = FirebaseFirestore.instance.collection("veiculos");
  bool _isLoading = false;

  List<DropdownMenuItem<String>> get dropsdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "cadastrado", child: Text('CADASTRADO')),
      const DropdownMenuItem(value: "lavando", child: Text('LAVANDO')),
      const DropdownMenuItem(value: "finalizado", child: Text('FINALIZADO')),
    ];
    return menuItems;
  }

  _loadFormData(VeiculoModel car) {
    _formData['modelo'] = car.modelo;
    _formData['placa'] = car.placa;
    _formData['cor'] = car.cor;
    _formData['status'] = car.status.name;
    _formData['observacao'] = car.observacao;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.veiculoModel != null) {
      _loadFormData(widget.veiculoModel!);
    }
  }

  validate() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid && widget.veiculoModel != null) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      _firebaseStore
          .doc(
            widget.veiculoModel!.id,
          )
          .update({
            'id': _formData['id'],
            'modelo': _formData['modelo'],
            'placa': _formData['placa'],
            'cor': _formData['cor'],
            'status': _formData['status'],
            'observacao': _formData['observacao'],
          })
          .then((value) => debugPrint('Update efetuado'))
          .catchError((error) => debugPrint("$error"));
      setState(() {
        _isLoading = false;
      });

      Navigator.pop(context);
    } else if (isValid && widget.veiculoModel == null) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      DocumentReference documentReference = _firebaseStore.doc();
      final documentId = documentReference.id;

      await documentReference
          .set({
            'id': documentId,
            'modelo': _formData['modelo'],
            'placa': _formData['placa'],
            'cor': _formData['cor'],
            'status': _formData['status'],
            'observacao': _formData['observacao'],
          })
          .then((value) => debugPrint('Inserção efetuada'))
          .catchError((error) => debugPrint("$error"));

      setState(() {
        _isLoading = false;
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.veiculoModel != null
            ? 'Editar veículo'
            : 'Cadastrar veículo'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: _formData['modelo'],
                              decoration: InputDecoration(
                                  hintText: 'Modelo',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onSaved: (value) => _formData['modelo'] = value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Preencher o campo';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              initialValue: _formData['placa'],
                              decoration: InputDecoration(
                                  hintText: 'placa',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onSaved: (value) => _formData['placa'] = value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Preencher o campo';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              initialValue: _formData['cor'],
                              decoration: InputDecoration(
                                  hintText: 'cor',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onSaved: (value) => _formData['cor'] = value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Preencher o campo';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              initialValue: _formData['observacao'],
                              decoration: InputDecoration(
                                  hintText: 'Observações',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onSaved: (value) =>
                                  _formData['observacao'] = value,
                            ),
                            const SizedBox(height: 10),
                            DropdownButton(
                                padding: const EdgeInsets.only(left: 15),
                                items: dropsdownItems,
                                value: _formData['status'] ?? "cadastrado",
                                onChanged: (newValue) {
                                  setState(() {
                                    _formData['status'] = newValue!.toString();
                                    debugPrint(_formData['status']);
                                  });
                                }),
                            const SizedBox(height: 26),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xffC7CCDB)),
                                    onPressed: validate,
                                    child: Text(
                                      widget.veiculoModel != null
                                          ? 'Atualizar'
                                          : 'Cadastrar',
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    )),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}
