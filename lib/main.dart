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
                    MaterialPageRoute(builder: (context) => exePage())  //轉跳頁面
                );
              },
              child: Text('練習'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => quizPage()) //轉跳頁面
                );
              },
              child: Text('測驗'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => vocPage())  //轉跳頁面
                );
              },
              child: Text('單字卡'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settingPage())  //轉跳頁面
                );
              },
              child: Text('設定'),
            ),
          ],
        )
    );
  }
}

//使exePage可以使用setState函式（暫無用）
// class exePageState extends StatefulWidget {
//   @override
//   exePage createState() => exePage();
// }

class exePage extends StatelessWidget {
  var article = "Sara is hungry. "; //範例文章
      // "She goes to the kitchen. "
      // "She opens the cabinet. There are a lot of snacks. "
      // "The marshmallows are too sweet. "
      // "The potato chips are too salty. "
      // "The ice cream is too watery. "
      // "The kiwis are too sour. The cereal is too bland. "
      // "Her dad comes home. He gives her crackers. The crackers are perfect.";
  IconData micicon = Icons.mic_outlined;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('練習'),
      ),
      body:
        Column(
          children: <Widget>[
            Text(article),
            Row(
              children: <Widget>[
                ElevatedButton.icon(
                  icon: Icon(Icons.headphones_outlined,),
                  label: Text(""),
                  onPressed: sound,
                ),
                ElevatedButton.icon(
                  icon: Icon(micicon),
                  label: Text(""),
                  onPressed: () {
                    print('Mic');
                    // setState(() {  //控制錄音按鈕圖形切換
                    //   if (micicon == Icons.mic_outlined)
                    //     micicon = Icons.stop_circle_outlined;
                    //   else
                    //     micicon = Icons.mic_outlined;
                    // });
                  },
                )
               ],
            )
          ]
        )
    );
  }
  void sound() {
    print('Speech');
  }
}

class quizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('測驗'),
      ),
      body: quizPageBody(),
    );
  }
}

class quizPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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
      body: vocPageBody(),
    );
  }
}

class vocPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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
      body: settingPageBody(),
    );
  }
}

class settingPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
    );
  }
}