import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gachi_match/domain/record.dart';
import 'package:gachi_match/properties/edit_record/edit_page.dart';

import 'package:gachi_match/properties/list_page/ListModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecordListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecordListModel>(
        create: (_) => RecordListModel()..fetchRecords(),
        child: Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.backspace),
            //   onPressed: () {},
            // ),
            title: Consumer<RecordListModel>(builder: (context, model, child) {
              model.records.forEach((record) {
                print(record.createdAt.toDate().toLocal().timeZoneName);
                //print(Intl.defaultLocale);
              });
              return Text(model.userName);
            }),
          ),
          body: Consumer<RecordListModel>(
            builder: (context, model, child) {
              final records = model.records;
              // DateTime date = DateTime.now().toLocal();
              // print(date);
              // print(date.timeZoneName);
              final listTiles = records
                  .map((record) => ListTile(
                        // leading: Icon(Icons.thumb_up),
                        title: Text('${record.xPower.toString()}'),
                        subtitle: Text(DateFormat('MM月dd日 HH時mm分')
                            .format(record.createdAt.toDate().toLocal())
                            .toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
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
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ],
            currentIndex: 2,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
          floatingActionButton:
              Consumer<RecordListModel>(builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.pushNamed(context, '/add');
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

  void _onItemTapped(int index) {
    int a = 0;
    a++;
    print(a);
  }
}
