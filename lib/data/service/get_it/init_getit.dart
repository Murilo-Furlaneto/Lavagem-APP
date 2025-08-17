import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:lavagem_app/viewmodel/user_viewmodel.dart';
import 'package:lavagem_app/viewmodel/veiculo_viewmodel.dart';
import 'package:lavagem_app/data/repository/user_repository.dart';
import 'package:lavagem_app/data/repository/veiculo_repository.dart';
import 'package:lavagem_app/data/service/firebase/user_service.dart';
import 'package:lavagem_app/data/service/firebase/veiculo_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<UserRepository>(UserRepository(userService:  getIt.get<UserService>()));
  getIt.registerSingleton<VeiculoRepository>(VeiculoRepository(VeiculoService()));
  getIt.registerSingleton<VeiculoViewModel>(VeiculoViewModel());
  getIt.registerSingleton(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<UserViewModel>(UserViewModel(userRepository: getIt.get<UserRepository>()));
  getIt.registerSingleton<UserService>(UserService());
  getIt.registerSingleton<VeiculoService>(VeiculoService());  
}
