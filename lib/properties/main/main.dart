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

void main() {
  Intl.defaultLocale = 'ja_JP';
  initializeDateFormatting('ja-JP', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/sign_up': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/list': (context) => RecordListPage(),

        // '/edit': (context) => EditPage(),
        '/add': (context) => AddRecordPage(),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 120),
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
