import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('主頁'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          RaisedButton(
            onPressed: (){},
            child: Text('練習'),
          ),
          RaisedButton(
            onPressed: (){},
            child: Text('測驗'),
          ),
          RaisedButton(
            onPressed: (){},
            child: Text('單字卡'),
          ),
          RaisedButton(
            onPressed: (){},
            child: Text('設定'),
          ),
        ],
      )
    );
  }

  void btnClickEvent() {
    print('btnClickEvent');
  }
  void btnClickEvent2() {
    print('btnClickEvent2');
  }
}