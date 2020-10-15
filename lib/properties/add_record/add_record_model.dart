import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AddRecordModel extends ChangeNotifier {
  Future addRecord(int xPower) async {
    User user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('records').add({
      'xPower': xPower,
      'userId': user.uid,
      'createdAt': Timestamp.now(),
      'ruleId': 0,
    });
  }
}
