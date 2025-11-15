import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:lavagem_app/data/database/app_database.dart';
import 'package:lavagem_app/data/datasource/local/user_local_data_source.dart';
import 'package:lavagem_app/data/datasource/remote/user_remote_data_source.dart';
import 'package:lavagem_app/data/datasource/remote/vehicle_remote_data_source.dart';
import 'package:lavagem_app/data/helper/database/user_database_helper.dart';
import 'package:lavagem_app/domain/repository/user_repository.dart';
import 'package:lavagem_app/domain/repository/vehicle_repository.dart';
import 'package:lavagem_app/view/features/auth/view_model/user_viewmodel.dart';
import 'package:lavagem_app/view/features/veiculos/viewmodel/vehicle_viewmodel.dart';
import 'package:lavagem_app/data/repository/user_repository_impl.dart';
import 'package:lavagem_app/data/repository/vehicle_repository_impl.dart';
import 'package:lavagem_app/data/service/firebase/user_service.dart';
import 'package:lavagem_app/data/service/firebase/vehicle_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl(UserRemoteDataSource(getIt<UserService>()), UserLocalDataSource(UserDatabaseHelper(AppDatabase()))));
  getIt.registerSingleton<VehicleRepository>(VehicleRepositoryImpl(VehicleRemoteDataSource(VehicleService())));
  getIt.registerSingleton<VehicleViewModel>(VehicleViewModel(getIt.get<VehicleRepository>()));
  getIt.registerSingleton(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<UserViewModel>(UserViewModel(userRepository: getIt.get<UserRepository>()));
  getIt.registerSingleton<UserService>(UserService());
  getIt.registerSingleton<VehicleService>(VehicleService());  
}
