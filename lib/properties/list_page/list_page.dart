import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gachi_match/domain/record.dart';
import 'package:gachi_match/properties/add_record/add_record_page.dart';
import 'package:gachi_match/properties/edit_record/edit_page.dart';

import 'package:gachi_match/properties/list_page/liser_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecordListPage extends StatelessWidget {
  // RecordListPage({this.ruleId});
  // final int ruleId;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecordListModel>(
        create: (_) => RecordListModel()..fetchRecords(),
        child: Scaffold(
          appBar: AppBar(
            // leading: Icon(Icons.logout),
            title: Consumer<RecordListModel>(builder: (context, model, child) {
              return Text(model.userName);
            }),
          ),
          body: Consumer<RecordListModel>(
            builder: (context, model, child) {
              final records = model.records;
              final listTiles = records
                  .map((record) => ListTile(
                        title: Text('${record.xPower.toString()}'),
                        subtitle: Text(DateFormat('MM月dd日 HH時mm分')
                            .format(record.createdAt.toDate().toLocal())
                            .toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            // await Navigator.pushNamed(context, '/edit',
                            //     arguments: {record: record});
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(
                                  record: record,
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                            model.fetchRecords();
                          },
                        ),
                        onLongPress: () async {
                          await deleteRecord(model, record, context);
                        },
                      ))
                  .toList();
              listTiles.insert(
                  0,
                  ListTile(
                      title: Text('最終XP',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      subtitle: Text('プレイした時刻'),
                      trailing: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('編集'),
                      )));
              return ListView(
                children: listTiles,
              );
            },
          ),
          bottomNavigationBar: Consumer<RecordListModel>(
            builder: (context, model, child) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'エリア',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'ヤグラ',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'ホコ',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'アサリ',
                  ),
                ],
                currentIndex: model.ruleId,
                selectedItemColor: Colors.amber[800],
                onTap: (index) async {
                  model.ruleId = index;
                  await model.fetchRecords();
                },
              );
            },
          ),
          floatingActionButton:
              Consumer<RecordListModel>(builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                // int ruleId = model.rule
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddRecordPage(ruleId: model.ruleId)),
                );
                model.fetchRecords();
              }, // onPress
            );
          }),
        ));
  }

  Future deleteRecord(
      RecordListModel model, Record record, BuildContext context) async {
    try {
      // ダイアログDialog
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(record.createdAt.toDate().toString()),
            content: Text('削除しますか？'),
            actions: <Widget>[
              TextButton(
                child: Text('削除'),
                onPressed: () async {
                  await model.deleteRecord(record);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/list');
                  await model.fetchRecords();
                },
              ),
              TextButton(
                child: Text('キャンセル'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/list');
                },
              )
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      // ダイアログDialog
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('本の追加'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('閉じる'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
