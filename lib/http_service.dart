import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_html/html.dart' as html;

const int TIME_OUT = 3;

class Connect {
  var sentence;
  Future getPosts() async {
    const url = 'http://172.20.10.10:8000/article';
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

abstract class DownloadService {
  Future<void> download({required String url});
}

class WebDownloadService implements DownloadService {
  @override
  Future<void> download({required String url}) async {
    html.window.open(url, "_blank");
  }
}

class MobileDownloadService implements DownloadService {
  @override
  Future<void> download({required String url}) async {
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return;

    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();

    // You should put the name you want for the file here.
    // Take in account the extension.
    String fileName = 'example';
    await dio.download(url, "${dir.path}/$fileName");
  }

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage
        .request()
        .isGranted;
  }
}
