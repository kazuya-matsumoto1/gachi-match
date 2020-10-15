import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  Record(DocumentSnapshot doc) {
    this.recordId = doc.id;
    // todo: userId
    this.userId = doc['userId'];
    this.createdAt = Timestamp.now();
    this.xPower = doc['xPower'];
    this.winCount = doc['winCount'];
    this.loseCount = doc['loseCount'];
  }

  String recordId = '';
  String userId = '';
  Timestamp createdAt;
  int xPower = 0;
  int winCount = 0;
  int loseCount = 0;
}
