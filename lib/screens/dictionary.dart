import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DictionaryPage extends StatefulWidget {
  @override
  DictionaryPageState createState() => DictionaryPageState();
}

class DictionaryPageState extends State<DictionaryPage> {
  String _url = "https://owlbot.info/api/v4/dictionary/";
  String _token = "2b030216fc3046efd7f2e3029af8152b2f0a1313";

  TextEditingController _controller = TextEditingController();

  StreamController _streamController;
  Stream _stream;

  Timer _debounce;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    } else {
      _streamController.add('waiting');
      Response response = await get(Uri.parse(_url + _controller.text.trim()),
          headers: {"Authorization": "Token " + _token});
      if (response.body.contains('[{"message":"No definition :("}]')) {
        _streamController.add('NoData');
        return;
      } else {
        _streamController.add(json.decode(response.body));
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("單 字 查 詢"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    onChanged: (String text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                        _search();
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Search for a word",
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  _search();
                },
              )
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: _stream,
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text("Enter a search word"),
              );
            }
            if (snapshot.data == "waiting") {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == "NoData") {
              return Center(
                child: Text("No Defination"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data["definitions"].length,
              itemBuilder: (BuildContext context, int index) {
                var text = snapshot.data["definitions"][index]["definition"];
                return ListBody(
                  children: <Widget>[
                    Container(
                      color: Colors.grey[300],
                      child: ListTile(
                        leading: snapshot.data["definitions"][index]
                                    ["image_url"] ==
                                null
                            ? null
                            : CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data["definitions"][index]["image_url"]),
                              ),
                        title: Text(_controller.text.trim() +
                            " " +
                            "(" +
                            snapshot.data["definitions"][index]["type"] +
                            ")"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  show_dic(){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          child: FutureBuilder(
            future: _search(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  constraints: const BoxConstraints(
                      maxWidth: 300,
                      maxHeight: 300,
                      minWidth: 50,
                      minHeight: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data["definitions"].length,
                          itemBuilder: (BuildContext context, int index) {
                            var text = snapshot.data["definitions"][index]["definition"];
                            return ListBody(
                              children: <Widget>[
                                Container(
                                  color: Colors.grey[300],
                                  child: ListTile(
                                    leading: snapshot.data["definitions"][index]
                                    ["image_url"] ==
                                        null
                                        ? null
                                        : CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot
                                          .data["definitions"][index]["image_url"]),
                                    ),
                                    title: Text(_controller.text.trim() +
                                        " " +
                                        "(" +
                                        snapshot.data["definitions"][index]["type"] +
                                        ")"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(text),
                                )
                              ],
                            );
                          },),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("關閉",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Text("");
              }
            },
          ),
        );
      },
    );
  }

}
