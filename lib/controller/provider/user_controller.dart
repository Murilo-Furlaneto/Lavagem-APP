import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavagem_app/pages/home_page.dart';
import 'package:lavagem_app/pages/sign_up_page.dart';
import 'package:lavagem_app/service/firebase_service.dart';
import 'package:lavagem_app/service/firebase_service_impl.dart';
import 'package:lavagem_app/widgets/message_firebase_widget.dart';

class UserController extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseServiceImp();

  Future<void> resetarSenha(
      {required String email, required BuildContext context}) async {
    await _firebaseService.resetSenha(email: email, context: context);
  }

  Future<void> cadastrarUsuario(
      {required String nome,
      required String email,
      required String senha,
      required bool isConsultor,
      required BuildContext context}) async {
    try {
      await _firebaseService.cadastrar(
        nome: nome,
        email: email,
        senha: senha,
        isConsultor: isConsultor,
        context: context,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            nome: nome,
            consultor: isConsultor,
          ),
        ),
        (route) => false,
      );
    } catch (e) {
      SnackBarUtil.showError(
          context, 'Erro ao fazer cadastro. Por favor, tente novamente.');
    }
  }

  Future<void> login(
      {required String nome,
      required String email,
      required String senha,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await _firebaseService.login(
        nome: nome,
        email: email,
        senha: senha,
        context: context,
      );

      // Recupera o UID do usuário atual
      String uid = userCredential.user!.uid;

      // Busca o documento do usuário no Firestore
      DocumentSnapshot userDoc = await _firebaseService.getUserDocument(uid);

      if (!userDoc.exists) {
        throw Exception('Usuário não encontrado no Firestore');
      }

      // Obtém os dados do usuário do Firestore
      var userData = userDoc.data() as Map<String, dynamic>;
      bool isConsultor = userData['isConsultor'] ?? false;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            nome: nome,
            consultor: isConsultor,
          ),
        ),
      );
    } catch (e) {
      SnackBarUtil.showError(
          context, 'Erro ao fazer login. Por favor, tente novamente.');
    }
  }

  void hasUser(BuildContext context) {
    _firebaseService.authStateChanges().listen((User? user) async {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignUpPage()),
        );
      } else {
        String uid = user.uid;

        DocumentSnapshot userDoc = await _firebaseService.getUserDocument(uid);

        if (!userDoc.exists) {
          SnackBarUtil.showError(
              context, 'Usuário não encontrado no Firestore');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignUpPage()),
          );
        } else {
          // Obtém os dados do usuário do Firestore
          var userData = userDoc.data() as Map<String, dynamic>;
          bool isConsultor = userData['isConsultor'] ?? false;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                nome: user.displayName ?? '',
                consultor: isConsultor,
              ),
            ),
          );
        }
      }
    });
  }
}
