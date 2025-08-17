import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lavagem_app/data/service/get_it/init_getit.dart';
import 'package:lavagem_app/pages/check_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lavagem_app/viewmodel/user_viewmodel.dart';
import 'package:lavagem_app/viewmodel/veiculo_viewmodel.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt.get<UserViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt.get<VeiculoViewModel>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lavagem App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const CheckPage(),
      ),
    );
  }
}
