import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lavagem_app/data/service/get_it/init_getit.dart';
import 'package:lavagem_app/viewmodel/user_viewmodel.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    verifiaUsuarioLogado();
  }

  verifiaUsuarioLogado() {
    getIt<UserViewModel>().verificaSeExisteUsuario();
  }

  @override
  void dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
