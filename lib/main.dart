import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lavagem_app/controller/veiculo_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/check_page.dart';

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
      providers: [ChangeNotifierProvider(create: (_) => VeiculoProvider())],
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
