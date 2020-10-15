import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String email = '';
  String password = '';
  String name = '';

  Future signUp(BuildContext context) async {
    //  FireAuthの新規登録処理
    if (name.isEmpty) {
      throw ('名前を入力してください');
    }
    if (email.isEmpty) {
      throw ('メールアドレスを入力してください');
    }
    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final User user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      'name': name,
      'email': email,
      'id': user.uid,
      'createdAt': Timestamp.now(),
    });
  }
}
