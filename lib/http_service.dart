import 'dart:convert';
import 'dart:io';

const int TIME_OUT = 3;

class Connect {
  Future getPosts() async {
    final url = 'http://192.168.0.232:8000/';
    final client = HttpClient();
    final request = await client.getUrl(Uri.parse(url)).timeout(Duration(seconds: 3));
    final response = await request.close();
    if (response.statusCode == 200) {
      var body = await response.transform(Utf8Decoder()).join();
      return body;
    } else {
      print("Failed to Get Body.");
      throw "Unable to retrieve posts.";
    }
  }
}
