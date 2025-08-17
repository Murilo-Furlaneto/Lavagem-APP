import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lavagem_app/data/service/get_it/init_getit.dart';
import 'package:lavagem_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static final String _keyUsuarioLogado = dotenv.get('USUARIO_LOGADO_KEY');


  Future<void> resetarSenha(String email) async {
    await getIt<FirebaseAuth>().sendPasswordResetEmail(email: email);
  }

  Future<void> cadastrar(UserModel usuario) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await verificarEmail(usuario.email);

      UserCredential userCredential =
          await getIt<FirebaseAuth>().createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha,
      );

      await userCredential.user!.updateDisplayName(usuario.nome);

      final userData = usuario.toMap();

      await getIt<FirebaseFirestore>()
          .collection('usuario')
          .doc(userCredential.user!.uid)
          .set(userData);

      prefs.setString(_keyUsuarioLogado, usuario.toJson());
    } catch (e, stackTrace) {
      log(
        "Erro ao cadastrar usuário.",
        name: "UserRepository",
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception("Erro ao cadastrar usuário: $e");
    }
  }

  Future<void> verificarEmail(String email) async {
    try {
      final signInMethods =
          await getIt<FirebaseAuth>().fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        throw Exception("Esse email já está cadastrado");
      }
    } catch (e, stackTrace) {
      log(
        "Erro ao verificar email.",
        name: "UserRepository",
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception("Erro ao verificar email: $e");
    }
  }

  Future<void> login(String email, String senha) async {
    try {
      UserCredential userCredential =
          await getIt<FirebaseAuth>().signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      String uid = userCredential.user!.uid;

      DocumentSnapshot userDoc =
          await getIt<FirebaseFirestore>().collection('usuario').doc(uid).get();

      if (!userDoc.exists) {
        throw Exception('Usuário não encontrado');
      }
    } on FirebaseAuthException catch (e, stackTrace) {
      log(
        "Erro ao fazer login.",
        name: "UserRepository",
        error: e,
        stackTrace: stackTrace,
      );
      if (e.code == 'user-not-found') {
        throw Exception('Usuário não encontrado.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Senha incorreta.');
      } else {
        throw Exception("Erro ao fazer login: $e");
      }
    }
  }

  Future<void> logOut() async {
    await getIt<FirebaseAuth>().signOut();
  }

  

  
  /* getIt<FirebaseAuth>().authStateChanges().listen((User? user) async {
      if (user == null) {
        log("Usuário não autenticado.");
      } else {
        String uid = user.uid;
        DocumentSnapshot userDoc = await getIt<FirebaseFirestore>()
            .collection('usuario')
            .doc(uid)
            .get();

        if (!userDoc.exists) {
          log("Usuário não encontrado no Firestore.");
        } else {
          log("Usuário encontrado: ${user.displayName}");
        }
      }
    }); */
}
