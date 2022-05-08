import 'package:flutter/material.dart';
import 'http_service.dart';

class PostsPage extends StatelessWidget {
  final Connect httpService = Connect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            String posts = snapshot.data;
            return Center(child: Text(posts,
                                      style: TextStyle(fontSize: 25),
                                      textAlign: TextAlign.center,));
          } else {
            return Center(child: Text("No Data."));
          }
        },
      ),
    );
  }
}