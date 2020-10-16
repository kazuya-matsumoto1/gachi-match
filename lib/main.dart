import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gachi_match/properties/add_record/add_record_page.dart';
import 'package:gachi_match/properties/edit_record/edit_page.dart';
import 'package:gachi_match/properties/list_page/list_page.dart';
import 'package:gachi_match/properties/login/login_page.dart';
import 'package:gachi_match/properties/sign_up/sign_up_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// Future<void> _initialise() async {
//   await

//   await initializeDateFormatting("ja-JP", null);
// }

void main() async {
  Firebase.initializeApp();
  Intl.defaultLocale = 'ja_JP';

  await initializeDateFormatting('ja-JP', null);

  runApp(MyApp());
}

bool _checkLogin() {
  return !(FirebaseAuth.instance.currentUser == null);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // if (_checkLogin()) {
    //   return RecordListPage();
    // }
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/sign_up': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/list': (context) => RecordListPage(),

        // '/edit': (context) => EditPage(),
        // '/add': (context) => AddRecordPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: (_checkLogin() == true ? RecordListPage() : MyHomePage())
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    return Scaffold(
      appBar: AppBar(
        title: Text('ガチマッチ記録アプリ'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ガチマッチ戦績記録アプリ',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            Card(
              child: Column(
                children: [
                  Text(
                    'ガチマッチをプレイした時間と、終了時点のXパワーを記録していくことができるアプリです。',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'XPの変化量を意識しながら対戦することで、集中力と勝率も上がるはず。。。',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('新規登録'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('ログイン'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ),
              ],
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
