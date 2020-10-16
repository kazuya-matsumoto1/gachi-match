import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gachi_match/properties/list_page/list_page.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mailController = TextEditingController();
    final _passwordController = TextEditingController();

    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ログイン'),
        ),
        body: Consumer<LoginModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: 'example@example.com'),
                  controller: _mailController,
                  onChanged: (text) {
                    model.email = text;
                  },
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'パスワード',
                  ),
                  controller: _passwordController,
                  onChanged: (text) {
                    model.password = text;
                  },
                ),
                RaisedButton(
                  child: Text('ログイン'),
                  onPressed: () async {
                    //todo: 登録処理
                    try {
                      await model.login();
                      Navigator.pushNamed(context, '/list');
                    } catch (e) {
                      print(e.toString());
                      _showDialog(context, 'ログイン失敗', e.toString(), '/login');
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

  Future _showDialog(
      BuildContext context, String title, String message, String route) {
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
                Navigator.pushNamed(context, route);
              },
            ),
          ],
        );
      },
    );
  }
}
