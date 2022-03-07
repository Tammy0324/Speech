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

// class exePageState extends StatefulWidget {
//   @override
//   exePage createState() => exePage();
// }

class exePage extends StatelessWidget {
  var article = "Sara is hungry. She goes to the kitchen. "
      "She opens the cabinet. There are a lot of snacks. "
      "The marshmallows are too sweet. "
      "The potato chips are too salty. "
      "The ice cream is too watery. "
      "The kiwis are too sour. The cereal is too bland. "
      "Her dad comes home. He gives her crackers. The crackers are perfect.";
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
                    // setState(() {
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

// class exePageBody extends State<exePageBodyState> {
// var client = HttpClient();
//   var article = "Sara is hungry. She goes to the kitchen. "
//       "She opens the cabinet. There are a lot of snacks. "
//       "The marshmallows are too sweet. "
//       "The potato chips are too salty. "
//       "The ice cream is too watery. "
//       "The kiwis are too sour. The cereal is too bland. "
//       "Her dad comes home. He gives her crackers. The crackers are perfect.";
// getArticle () async {
//   var request = await client.getUrl(
//     Uri.https('127.0.0.1:8000','/')
//   );
//   var response = await request.close();
//   article = await response.join();
// }
//   @override
//   Widget build(BuildContext context) {
//     IconData micicon = Icons.mic_outlined;
//     return Center(
//       child: Column(
//         children: <Widget>[
//           Text(article),
//           Row(
//             children: <Widget>[
//               ElevatedButton.icon(
//                 icon: Icon(Icons.headphones_outlined,),
//                 label: Text(""),
//                 onPressed: sound,
//               ),
//               ElevatedButton.icon(
//                 icon: Icon(micicon),
//                 label: Text(""),
//                 onPressed: () {
//                   setState(() {
//                     if (micicon == Icons.mic_outlined)
//                       micicon = Icons.stop_circle_outlined;
//                     else
//                       micicon = Icons.mic_outlined;
//                   });
//               },
//               )
//             ],
//           )
//         ]
//       )
//     );
//   }
//   void sound() {
//     print('Speech');
//   }
// }

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