import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavagem_app/widgets/message_firebase_widget.dart';
import '../models/user_model.dart';
import '../pages/login_page.dart';
import 'firebase_service.dart';

class FirebaseServiceImp implements FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<void> resetSenha(
      {required String email, required BuildContext context}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      SnackBarUtil.showSuccess(context, 'Link enviado para o seu email');
    } on FirebaseAuthException catch (e) {
      SnackBarUtil.showError(
          context, e.message ?? 'Erro ao enviar link de reset de senha');
    }
  }

  @override
  Future<void> cadastrar({
    required String nome,
    required String email,
    required String senha,
    required bool isConsultor,
    required BuildContext context,
  }) async {
    try {
      // Verifica se o email já existe
      final signInMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        SnackBarUtil.showError(context, 'Esse email já está cadastrado');
        return;
      }

      // Cria a conta do usuário
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      var user = UserModel(
        nome: nome,
        email: email,
        senha: senha,
        isConsultor: isConsultor,
      );

      await _fireStore
          .collection('usuario')
          .doc(userCredential.user!.uid)
          .set(user.toMap());
      await _firebaseAuth.currentUser!.updateDisplayName(nome);

      SnackBarUtil.showSuccess(context, 'Cadastro realizado com sucesso');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserCredential> login({
    required String nome,
    required String email,
    required String senha,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Recupera o UID do usuário atual
      String uid = userCredential.user!.uid;

      // Busca o documento do usuário no Firestore
      DocumentSnapshot userDoc =
          await _fireStore.collection('usuario').doc(uid).get();

      if (!userDoc.exists) {
        throw Exception('Usuário não encontrado no Firestore');
      }

      // Obtém os dados do usuário do Firestore
      var userData = userDoc.data() as Map<String, dynamic>;
      bool isConsultor = userData['isConsultor'] ?? false;

      await _firebaseAuth.currentUser!.updateDisplayName(nome);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarUtil.showError(context, 'Usuário não encontrado.');
      } else if (e.code == 'wrong-password') {
        SnackBarUtil.showError(context, 'Senha incorreta.');
      } else {
        SnackBarUtil.showError(
            context, 'Erro ao fazer login. Por favor, tente novamente.');
      }
      rethrow;
    }
  }

  @override
  Future<void> logOut({required BuildContext context}) async {
    await _firebaseAuth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Future<DocumentSnapshot> getUserDocument(String uid) async {
    return await _fireStore.collection('usuario').doc(uid).get();
  }

  @override
  Future<void> updateDisplayName(String nome) async {
    await _firebaseAuth.currentUser!.updateDisplayName(nome);
  }

   @override
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}
