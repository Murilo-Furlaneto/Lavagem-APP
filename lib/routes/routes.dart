import 'package:flutter/material.dart';
import 'package:lavagem_app/data/service/get_it/init_getit.dart';
import 'package:lavagem_app/pages/auth/login_page.dart';
import 'package:lavagem_app/pages/auth/sign_up_page.dart';
import 'package:lavagem_app/pages/home/home_page.dart';
import 'package:lavagem_app/viewmodel/user_viewmodel.dart';
import 'package:lavagem_app/viewmodel/veiculo_viewmodel.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String sign_up = '/sign_up';

  static Map<String, WidgetBuilder> routes = {
    home: (context) =>  HomePage(veiculoViewModel: getIt<VeiculoViewModel>(),userViewModel: getIt<UserViewModel>(),),
    login: (context) => LoginPage(userViewModel: getIt<UserViewModel>()),
    sign_up: (context) => const SignUpPage(),
  };
}