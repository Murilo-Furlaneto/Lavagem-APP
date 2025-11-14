import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseService {
  Future<void> resetSenha({required String email});

  Future<void> cadastrar({
    required String nome,
    required String email,
    required String senha,
    required bool isConsultor,
  });
  Future<UserCredential> login(
      {required String nome, required String email, required String senha});
  Future<DocumentSnapshot> getUserDocument(String uid);
  Future<void> updateDisplayName(String nome);
  Future<void> logOut();
  Stream<User?> authStateChanges();
}
