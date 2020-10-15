import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gachi_match/domain/record.dart';

class AddRecordPage extends StatelessWidget {
  AddRecordPage({this.record});
  final Record record;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(title: Text('')),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'XPを入力'),
            ),
            RaisedButton(onPressed: () {}),
          ],
        ));
  }
}
