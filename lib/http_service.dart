import 'dart:convert';
import 'dart:io';
<<<<<<< Updated upstream
=======
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_html/html.dart' as html;
>>>>>>> Stashed changes

const int TIME_OUT = 3;

class Connect {
  var sentence;
  Future getPosts() async {
<<<<<<< Updated upstream
    final url = 'http://192.168.0.232:8000/';
=======
    const url = 'http://172.20.10.10:8000/article';
>>>>>>> Stashed changes
    final client = HttpClient();
    final request = await client.getUrl(Uri.parse(url)).timeout(Duration(seconds: 3));
    final response = await request.close();
    if (response.statusCode == 200) {
      var body = await response.transform(Utf8Decoder()).join();
      var sen = body.split("\\n");
      //print(sen);
      return sen;
    } else {
      print("Failed to Get Body.");
      throw "Unable to retrieve posts.";
    }
  }

}
