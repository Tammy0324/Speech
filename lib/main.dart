import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(home: new HomePage(),));

}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text('MyApp Demo')
        ),
        body: Row(
          children: <Widget>[
            Container(
              color: Colors.blueAccent,
              width: 100,
              height: 100,
            ),
            Container(
              color: Colors.red,
              width: 100,
              height: 100,
              margin: EdgeInsets.all(10.0),
            )
          ]
        )
    );
  }
}