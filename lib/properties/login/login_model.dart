import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginModel extends ChangeNotifier {
  String email = '';
  String password = '';

  Future login() async {
    // todo: FireAuthの新規登録処理
    if (email.isEmpty) {
      throw ('メールアドレスを入力してください');
    }
    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
  }
}
