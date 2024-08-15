import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class FirebaseService {
  Future<void> resetSenha({required String email, required BuildContext context});
  Future<void> cadastrar({
    required String nome,
    required String email,
    required String senha,
    required bool isConsultor,
    required BuildContext context,
  });
  Future<UserCredential> login({
    required String nome,
    required String email,
    required String senha,
    required BuildContext context,
  });
  Future<void> logOut({required BuildContext context});
  Future<DocumentSnapshot> getUserDocument(String uid);
  Future<void> updateDisplayName(String nome);
  Stream<User?> authStateChanges();
}
