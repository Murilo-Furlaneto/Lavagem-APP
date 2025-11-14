import 'package:flutter/material.dart';
import 'package:lavagem_app/di/init_getit.dart';
import 'package:lavagem_app/view/pages/auth/login_page.dart';
import 'package:lavagem_app/view/pages/auth/sign_up_page.dart';
import 'package:lavagem_app/view/pages/home/home_page.dart';
import 'package:lavagem_app/viewmodel/user_viewmodel.dart';
import 'package:lavagem_app/viewmodel/vehicle_viewmodel.dart';

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