import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lavagem_app/controller/provider/veiculo_controller.dart';
import 'package:lavagem_app/pages/sign_up_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => VeiculoController())],
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
