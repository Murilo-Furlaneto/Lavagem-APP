import 'package:flutter/material.dart';
import 'package:lavagem_app/di/init_getit.dart';
import 'package:lavagem_app/view/features/auth/pages/login_page.dart';
import 'package:lavagem_app/view/features/auth/pages/sign_up_page.dart';
import 'package:lavagem_app/view/features/home/pages/home_page.dart';
import 'package:lavagem_app/view/features/auth/view_model/user_viewmodel.dart';
import 'package:lavagem_app/view/features/veiculos/viewmodel/vehicle_viewmodel.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String sign_up = '/sign_up';

  static Map<String, WidgetBuilder> routes = {
    home: (context) =>  HomePage(veiculoViewModel: getIt<VehicleViewModel>(),userViewModel: getIt<UserViewModel>(),),
    login: (context) => LoginPage(userViewModel: getIt<UserViewModel>()),
    sign_up: (context) => const SignUpPage(),
  };
}