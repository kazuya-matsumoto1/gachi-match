import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gachi_match/domain/record.dart';

class EditModel extends ChangeNotifier {
  int record = 0;

  Future updateBook(Record record) async {
    final document =
        FirebaseFirestore.instance.collection('records').doc(record.recordId);

    await document.update({
      'xPower': this.record,
    });
  }
}
