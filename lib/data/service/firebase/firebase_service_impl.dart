import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lavagem_app/core/error/app_error_manager.dart';
import 'package:lavagem_app/data/enum/enum_role.dart';
import 'package:lavagem_app/data/service/firebase/firebase_service.dart';
import '../../../domain/models/user_model.dart';

class FirebaseServiceImpl extends FirebaseService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseStore;
  final AppErrorManager _errorManager = AppErrorManager();

  FirebaseServiceImpl({
    required this.firebaseAuth,
    required this.firebaseStore,
  });

  @override
  Future<void> resetSenha({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e, st) {
      if (e.code == 'user-not-found') {
        _errorManager.logFirebaseError(
          message: e.message ?? 'Usuário não encontrado.',
          className: 'FirebaseServiceImpl',
          stackTrace: st,
          originalException: e,
        );
        log("Usuário não encontrado para esse email.");
        throw Exception('Usuário não encontrado para esse email.');
      } else {
        _errorManager.logFirebaseError(
          message: e.message ?? 'Erro ao enviar email de redefinição de senha.',
          className: 'FirebaseServiceImpl',
          stackTrace: st,
          originalException: e,
        );
        log("Erro ao enviar email de redefinição de senha: ${e.message}");
        throw Exception('Erro ao enviar email de redefinição de senha.');
      }
    } catch (e, st) {
      _errorManager.logFirebaseError(
        message: "Erro desconhecido ao enviar email de redefinição de senha.",
        className: "FirebaseServiceImpl",
        stackTrace: st,
        originalException: Exception("Erro desconhecido: ${e.toString()}"),
      );
      log("Erro desconhecido ao enviar email de redefinição de senha: ${e.toString()}");
      throw Exception(
          'Erro desconhecido ao enviar email de redefinição de senha.');
    }
  }

  @override
  Future<void> cadastrar({
    required String nome,
    required String email,
    required String senha,
    required bool isConsultor,
  }) async {
    try {
      final signInMethods =
          await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        log("Email já cadastrado.");
        return;
      }

      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha);

      var user = UserModel(
        nome: nome,
        email: email,
        senha: senha,
        funcao: isConsultor ? UserRole.consultor : UserRole.lavador,
      );

      await firebaseStore
          .collection('usuario')
          .doc(userCredential.user!.uid)
          .set(user.toMap());
      await firebaseAuth.currentUser!.updateDisplayName(nome);
    } catch (e, st) {
      _errorManager.logFirebaseError(
        message: "Erro ao cadastrar usuário: ${e.toString()}",
        className: "FirebaseServiceImpl",
        stackTrace: st,
        originalException: e is Exception ? e : Exception(e.toString()),
      );
      log("Erro ao cadastrar usuário: ${e.toString()}");
      throw Exception(e);
    }
  }

  @override
  Future<UserCredential> login({
    required String nome,
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: senha);

      String uid = userCredential.user!.uid;
      DocumentSnapshot userDoc =
          await firebaseStore.collection('usuario').doc(uid).get();

      if (!userDoc.exists) {
        throw Exception('Usuário não encontrado no Firestore');
      }

      await firebaseAuth.currentUser!.updateDisplayName(nome);

      return userCredential;
    } on FirebaseAuthException catch (e, st) {
      String msg;
      if (e.code == 'user-not-found') {
        msg = "Usuário não encontrado.";
      } else if (e.code == 'wrong-password') {
        msg = "Senha incorreta.";
      } else {
        msg = "Erro ao fazer login. Por favor, tente novamente.";
      }
      _errorManager.logFirebaseError(
        message: msg,
        className: 'FirebaseServiceImpl',
        stackTrace: st,
        originalException: e,
      );
      log("Erro ao fazer login: ${e.toString()}");
      rethrow;
    } catch (e, st) {
      _errorManager.logFirebaseError(
        message: "Erro desconhecido ao fazer login.",
        className: "FirebaseServiceImpl",
        stackTrace: st,
        originalException: e is Exception ? e : Exception(e.toString()),
      );
      log("Erro desconhecido ao fazer login: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    log("Deslogando usuário...");
    await firebaseAuth.signOut();
  }

  @override
  Future<DocumentSnapshot> getUserDocument(String uid) async {
    try {
      log("Buscando usuário no Firestore...");
      DocumentSnapshot doc =
          await firebaseStore.collection('usuario').doc(uid).get();
      if (!doc.exists) {
        _errorManager.logFirebaseError(
          message: "Usuário não encontrado no Firestore.",
          className: "FirebaseServiceImpl",
          originalException: Exception('Usuário não encontrado no Firestore'),
        );
        log("Usuário não encontrado no Firestore.");
        throw Exception('Usuário não encontrado no Firestore');
      }
      log("Usuário encontrado no Firestore.");
      return doc;
    } catch (e, st) {
      _errorManager.logFirebaseError(
        message: "Erro ao buscar usuário no Firestore.",
        className: "FirebaseServiceImpl",
        stackTrace: st,
        originalException: e is Exception ? e : Exception(e.toString()),
      );
      log("Erro ao buscar usuário: ${e.toString()}");
      throw Exception('Erro ao buscar usuário no Firestore');
    }
  }

  @override
  Future<void> updateDisplayName(String nome) async {
    try {
      await firebaseAuth.currentUser!.updateDisplayName(nome);
    } catch (e, st) {
      _errorManager.logFirebaseError(
        message: "Erro ao atualizar display name.",
        className: "FirebaseServiceImpl",
        stackTrace: st,
        originalException: e is Exception ? e : Exception(e.toString()),
      );
      log("Erro ao atualizar display name: ${e.toString()}");
      throw Exception('Erro ao atualizar display name');
    }
  }

  @override
  Stream<User?> authStateChanges() {
    return firebaseAuth.authStateChanges().map((user) {
      log("Estado de autenticação alterado: ${user?.uid ?? 'Nenhum usuário logado'}");
      return user;
    });
  }
}
