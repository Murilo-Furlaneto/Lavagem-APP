import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/sign_up_page.dart';

class FirebaseService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<void> cadastrar(
      {required String nome,
      required String email,
      required String senha,
      required BuildContext context}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      var user = UserModel(
        nome: nome,
        email: email,
        senha: senha,
      );

      _fireStore.collection('usuario').add(user.toMap());

      _firebaseAuth.currentUser!.updateDisplayName(nome);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              nome: nome,
            ),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha fraca. Crie uma mais forte'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Esse email já está cadastrado.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Erro ao fazer cadastro. Por favor, tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> login(
      {required String nome,
      required String email,
      required String senha,
      required BuildContext context}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      _firebaseAuth.currentUser!.updateDisplayName(nome);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            nome: nome,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado.'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha incorreta.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao fazer login. Por favor, tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  logOut({required BuildContext context}) async {
    await _firebaseAuth.signOut().then((user) => {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()))
        });
  }

  hasUser(
      {required StreamSubscription streamSubscription,
      required BuildContext context}) {
    streamSubscription = _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignUpPage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      nome: _firebaseAuth.currentUser!.displayName.toString(),
                    )));
      }
    });
  }
}
