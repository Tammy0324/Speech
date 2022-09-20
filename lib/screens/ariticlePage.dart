import 'package:flutter/material.dart';
import '../http_service.dart';

class Article extends StatefulWidget{
  @override
  _Article createState() => _Article();
}

class _Article extends State<Article> {
  @override
  Widget build(BuildContext context) {
    final Connect httpService = Connect();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("練習"),
            Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white),
                  ),
                  child: Text("單句練習",
                    style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      Navigator.pushNamed(context, '/audio',arguments: 0);
                    }
                ),
              ]
            ),
          ]
        )
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<String> posts = snapshot.data;
            return Center(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int num) {
                  var sen = posts[num];
                  return Center(
                    child: Text(
                      sen,
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              )
            );
          } else {
            return const Center(child: Text("No Data."));
          }
        }
      ),
    );
  }
}