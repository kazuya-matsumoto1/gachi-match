import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gachi_match/domain/record.dart';
import 'package:gachi_match/properties/list_page/list_page.dart';
import 'package:gachi_match/properties/login/login_page.dart';
import 'package:gachi_match/properties/sign_up/signup_model.dart';
import 'package:provider/provider.dart';

import 'edit_model.dart';

class EditPage extends StatelessWidget {
  EditPage({this.record});
  final Record record;
  @override
  Widget build(BuildContext context) {
    final recordController = TextEditingController();
    final String oldRecord = record.xPower.toString();

    //String name;

    return ChangeNotifierProvider<EditModel>(
      create: (_) => EditModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('編集'),
        ),
        body: Consumer<EditModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: oldRecord),
                  controller: recordController,
                  onChanged: (text) {
                    model.record = int.parse(text);
                  },
                ),
                Row(
                  children: [
                    RaisedButton(
                      child: Text('保存'),
                      onPressed: () async {
                        //todo: 登録処理
                        try {
                          await model.updateBook(record);
                          Navigator.of(context).pop();
                          // Navigator.of(context).pop();
                          // Navigator.pushNamed(context, '/list');

                          // await _showDialog(context, '新規登録', '登録完了しました');
                        } catch (e) {
                          _showDialog(context, '保存失敗', e.toString());
                        }
                      },
                    ),
                    RaisedButton(
                        child: Text('一覧へ戻る'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
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
