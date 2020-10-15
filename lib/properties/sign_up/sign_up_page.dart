import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gachi_match/properties/login/login_page.dart';
import 'package:gachi_match/properties/sign_up/signup_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    //String name;

    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規登録'),
        ),
        body: Consumer<SignUpModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(hintText: '名前'),
                  controller: nameController,
                  onChanged: (text) {
                    model.name = text;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'example@kboy.com'),
                  controller: mailController,
                  onChanged: (text) {
                    model.email = text;
                  },
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'パスワード'),
                  controller: passwordController,
                  onChanged: (text) {
                    model.password = text;
                  },
                ),
                RaisedButton(
                  child: Text('新規登録'),
                  onPressed: () async {
                    //todo: 登録処理
                    try {
                      await model.signUp(context);
                      await _showDialog(context, '新規登録', '登録完了しました');
                    } catch (e) {
                      _showDialog(context, '登録失敗', e.toString());
                    }
                  },
                ),
              ]),
            );
          },
        ),
      ),
    );
  }

  Future _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (title == '新規登録') {
                  Navigator.pushNamed(context, '/login');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
