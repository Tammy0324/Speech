import 'package:http/http.dart' as http;

const int TIME_OUT = 3;

class Connect {
  Uri url = Uri.parse('http://10.22.84.123:8000/');

  Future<String> getPosts() async {
    print("getPosts");
    final response = await http.get(Uri.parse('https://licman-dev.discoverelement.com:9443/api/service/version')).timeout(Duration(seconds: 3));
    print("Get Url");
    if (response.statusCode == 200) {
      print("Get Body.");
      String body = response.body;
      return body;
    } else {
      print("Failed toGet Body.");
      throw "Unable to retrieve posts.";
    }
  }
}
