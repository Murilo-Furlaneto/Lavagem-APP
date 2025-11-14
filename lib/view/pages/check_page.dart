import 'package:flutter/material.dart';
import 'package:lavagem_app/di/init_getit.dart';
import 'package:lavagem_app/routes/routes.dart';
import 'package:lavagem_app/viewmodel/user_viewmodel.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  final UserViewModel _userViewModel = getIt<UserViewModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _userViewModel.verificaSeExisteUsuario(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Erro ao verificar usuário'),
              );
            } else {
              final userExists = snapshot.data ?? false;
              if (userExists) {
                Navigator.pushReplacementNamed(context, Routes.home);
              } else {
                Navigator.pushReplacementNamed(context, Routes.login);
              }
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
