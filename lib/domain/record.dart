import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  Record(DocumentSnapshot doc) {
    this.recordId = doc.id;
    this.userId = doc['userId'];
    this.createdAt = doc['createdAt'];
    this.xPower = doc['xPower'];
    // this.ruleId = doc['ruleId'];
  }

  String recordId = '';
  String userId = '';
  Timestamp createdAt;
  int xPower = 0;
  int ruleId = 0;
}
