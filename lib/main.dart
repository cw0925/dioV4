import 'package:ball/models/ball.dart';
import 'package:ball/net/api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: OutlinedButton(
          child: Text('网络请求'),
          onPressed: (){ _netRequest(); },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  _netRequest() {
    //a9ed2a336f95e912111faaf2ead798fb
    // getRequest<String>('jztk/query',data: {"key":'88134775dcf8c7e9f33ff2f4f4fedf45','subject':1,'model':'c1'}).then((value) => {
    //   print('返回：'+value.toString())
    // });
    // getRequest<Ball>('/cwl_admin/kjxx/findDrawNotice',data: {"name":'ssq',"issueCount":100}).then((value) => {
    //   print('返回：'+value.toString())
    // });
    // request<String>('jztk/query',data: {"key":'88134775dcf8c7e9f33ff2f4f4fedf45','subject':1,'model':'c1'}).then((value) => {
    //   print('返回：'+value.toString())
    // });
  }
}
