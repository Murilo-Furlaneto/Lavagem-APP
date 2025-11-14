import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lavagem_app/di/init_getit.dart';
import 'package:lavagem_app/domain/repository/vehicle_repository.dart';
import 'package:lavagem_app/view/pages/auth/sign_up_page.dart';
import 'package:lavagem_app/viewmodel/vehicle_viewmodel.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => VehicleViewModel(getIt<VehicleRepository>()))],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lavagem App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const SignUpPage(),
      ),
    );
  }
}
