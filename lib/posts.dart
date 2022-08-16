import 'package:flutter/material.dart';
import 'http_service.dart';
import 'post_model.dart';

class PostsPage extends StatelessWidget {
  final Connect httpService = Connect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
<<<<<<< Updated upstream
            String posts = snapshot.data;
            return Text(posts);
=======
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
>>>>>>> Stashed changes
          } else {
            return Center(child: Text("No Data."));
          }
        },
      ),
    );
  }
}