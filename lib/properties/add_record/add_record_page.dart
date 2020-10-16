import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gachi_match/domain/record.dart';
import 'package:gachi_match/properties/add_record/add_record_model.dart';
import 'package:gachi_match/properties/list_page/list_page.dart';
import 'package:provider/provider.dart';

class AddRecordPage extends StatelessWidget {
  AddRecordPage({this.ruleId});
  final int ruleId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddRecordModel>(
      create: (_) => AddRecordModel(),
      child: Consumer<AddRecordModel>(
        builder: (context, model, child) {
          TextEditingController xPowerController = TextEditingController();
          return Scaffold(
              appBar: AppBar(title: Text('記録追加画面')),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      controller: xPowerController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'XPを入力'),
                    ),
                    RaisedButton(
                        child: Text('投稿'),
                        onPressed: () async {
                          await model.addRecord(
                              int.parse(xPowerController.text), this.ruleId);
                          // Navigator.pushNamed(context, '/list');
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
