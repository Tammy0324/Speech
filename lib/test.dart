import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Button'),),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[500],
          child: Icon(Icons.add_comment),
          tooltip:'測試',
          onPressed: () {print('loating Action Button');},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        body: MyBody(),

      ),
    );
  }
}

class MyBody extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  var value;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              RaisedButton(
                child: Text('普通按鈕'),
                onHighlightChanged:(bool b) {
                  print(b);
                },
                onPressed: (){},
              ),

              RaisedButton(
                child: Text('帶顏色'),
                onPressed: (){},
                textColor: Colors.white,
                color: Colors.blue[200],
              ),

              RaisedButton(
                child: Text('帶顏色帶陰影'),
                onPressed: (){},
                textColor: Colors.white,
                color: Colors.blue[200],
                elevation: 15,
              ),

              Container(
                width: 300,
                height: 50,
                child: RaisedButton(
                  child: Text('設定寬高'),
                  onPressed: (){},
                  textColor: Colors.white,
                  color: Colors.blue[500],
                  elevation: 15,
                ),
              ),

              RaisedButton.icon(
                icon: Icon(Icons.account_box),
                label: Text('我前邊有圖示'),
                onPressed: () {},
              ),

              RaisedButton(
                child: Text('圓角按鈕'),
                onPressed: (){},
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),

              Container(
                width: 100,
                height: 100,
                child: RaisedButton(
                    child: Text('圓形按鈕'),
                    onPressed: (){},
                    color: Colors.red,
                    shape: CircleBorder(
                      // side: BorderSide(color: Colors.yellow[500])
                    )
                ),
              ),

              RaisedButton(
                child: Text('水波紋'),
                onPressed: (){},
                color: Colors.blue[200],
                splashColor:Colors.yellow[100],
              ),

              RaisedButton(
                child: Text('長按變色'),
                onPressed: (){},
                color: Colors.blue[200],
                highlightColor:Colors.red[500],
              ),

              FlatButton(
                child: Text('扁平按鈕'),
                onPressed: (){},
                color: Colors.blue[200],
              ),

              OutlineButton(
                child: Text('邊框按鈕'),
                onPressed: (){},
                textColor: Colors.red,
                borderSide: BorderSide(color: Colors.red,),
              ),

              IconButton(
                icon: Icon(Icons.access_alarms),
                onPressed: () {},
                color: Colors.deepOrange,
                splashColor:Colors.limeAccent,
                highlightColor:Colors.blue[300],
                tooltip:'幹啥',
              ),

              DropdownButton(
                hint:new Text('請選擇...'),
                value: value,//下拉選單選擇完之後顯示給使用者的值
                iconSize: 50.0,//設定三角標icon的大小
                items: <DropdownMenuItem>[
                  DropdownMenuItem(
                    value: '1',
                    child: Text('One'),
                  ),
                  DropdownMenuItem(
                    value: '2',
                    child: Text('Two'),
                  ),
                  DropdownMenuItem(
                    value: '3',
                    child: Text('Three'),
                  ),
                  DropdownMenuItem(
                    value: '4',
                    child: Text('four'),
                  ),
                  DropdownMenuItem(
                    value: '5',
                    child: Text('five'),
                  ),
                ],
                onChanged: (v) {
                  setState(() {
                    print(v);
                    value = v;
                  });
                },
              ),
            ],
          ),


          Container(
            color: Colors.pink[100],
            child: ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('按鈕一'),
                  onPressed: (){},
                  textColor: Colors.white,
                  color: Colors.blue,
                  elevation: 15,
                ),
                RaisedButton(
                  child: Text('按鈕二'),
                  onPressed: (){},
                  textColor: Colors.white,
                  color: Colors.blue,
                  elevation: 15,
                ),
              ],
            ),
          ),

          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Text("一個Button事件與回撥，更改數值"),

                SizedBox(height: 15,),
                Text("$count",style: TextStyle(fontSize: 50,color: Colors.purple,fontWeight:FontWeight.w800)),
                SizedBox(height: 20,),

                RaisedButton(
                  child: Text('點我',style: TextStyle(fontSize: 18),),
                  onPressed: (){setState(() {
                    count += 1;
                  });},
                  textColor: Colors.white,
                  color: Colors.blue,
                  elevation: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );

  }
}