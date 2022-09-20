import 'package:flutter/material.dart';
import 'package:project/generated/l10n.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}): super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  } // _openDrawer()

  void _closeDrawer() {
    Navigator.of(context).pop();
  } // _closeDrawer()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      ListView(
        children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: Text('練習',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),),
                onTap: () {
                  Navigator.pushNamed(context, '/article',arguments: 0);
                },
                trailing: Icon(
                  Icons.play_arrow,
                  color: Colors.blueAccent,
                  //semanticLabel: 'Play $audioRec[index].title audio',
                ),
              ),
              ListTile(
                title: Text('測驗',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),),
                onTap: () {
                  Navigator.pushNamed(context, '/new_audio',arguments: 0);// 新增錄放音功能畫面
                },
                trailing: Icon(
                  Icons.play_arrow,
                  color: Colors.blueAccent,
                  //semanticLabel: 'Play $audioRec[index].title audio',
                ),
              ),
              ListTile(
                title: Text('單字卡',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),),
                // onTap: () {
                //   Navigator.pushNamed(context, '/audio',arguments: 0);
                // },
                trailing: Icon(
                  Icons.play_arrow,
                  color: Colors.blueAccent,
                  //semanticLabel: 'Play $audioRec[index].title audio',
                ),
              ),
            ]
        ).toList(),
      ),


      drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            // DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //   ),
            //   child: Text(
            //     'Drawer Header',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 30.0),
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        onPressed: () {
          Navigator.pushNamed(context, '/new');
        },
        tooltip: 'setting',
        child: Icon(Icons.settings),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}