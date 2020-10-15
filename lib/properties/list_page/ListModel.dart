import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gachi_match/domain/record.dart';

class RecordListModel extends ChangeNotifier {
  List<Record> records = [];
  String userName = '';
  int xPower;
  // int ruleId;
  String userId;
  Timestamp createdAt;
  Future fetchRecords() async {
    User user = FirebaseAuth.instance.currentUser;
    final docs = await FirebaseFirestore.instance
        .collection('records')
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .get();
    final records = docs.docs.map((doc) => Record(doc)).toList();
    this.records = records;
    await this.setUserName();
    notifyListeners();
  }

  Future deleteRecord(Record record) async {
    final document =
        FirebaseFirestore.instance.collection('records').doc(record.recordId);
    await document.delete();
  }

  Future setUserName() async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    this.userName = snapshot['name'];
  }

  Future addRecord() async {
    // if (bookTitle.isEmpty) {
    //   throw ('タイトルを入力してください');
    // }
    User user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('records').add({
      'xPower': 0,
      // 'ruleId': 0,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
    });
  }
}
