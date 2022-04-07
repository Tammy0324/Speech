import 'package:flutter/material.dart';
import 'http_service.dart';
import 'post_model.dart';

class PostsPage extends StatelessWidget {
  final Connect httpService = Connect();

  @override
  Widget build(BuildContext context) {
    print("PostPage");
    return Scaffold(
      body: FutureBuilder<String>(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            String posts = snapshot.data;
            print("posts: ");
            print(posts);
            return Text(posts);
          } else {
            return Center(child: Text("No Data."));
          }
        },
      ),
    );
  }
}