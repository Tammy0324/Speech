import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    return Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => exePage())
                );
              },
              child: Text('練習'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => quizPage())
                );
              },
              child: Text('測驗'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => vocPage())
                );
              },
              child: Text('單字卡'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settingPage())
                );
              },
              child: Text('設定'),
            ),
          ],
        )
    );
  }
}

class exePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('練習'),
      ),
      body: exePageBody(),
    );
  }
}

class exePageBody extends StatelessWidget {
  var client = HttpClient();
  var article = "";
  getArticle () async {
    var request = await client.getUrl(
      Uri.https('127.0.0.1:8000','/')
    );
    var response = await request.close();
    article = await response.join();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(article),
          RaisedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('返回主頁'),
          ),
        ]
      )
    );
  }
}

class quizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('測驗'),
      ),
      body: exePageBody(),
    );
  }
}

class quizPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Text('返回主頁'),
      ),
    );
  }
}

class vocPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('單字卡'),
      ),
      body: exePageBody(),
    );
  }
}

class vocPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Text('返回主頁'),
      ),
    );
  }
}

class settingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: exePageBody(),
    );
  }
}

class settingPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Text('返回主頁'),
      ),
    );
  }
}