import 'package:flutter/material.dart';
import 'package:tt_flutter/service/service_method.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageValue = '正在获取数据';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomePageContent().then((val) {
      setState(() {
        homePageValue = val.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('首页'),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Text(homePageValue),
      )),
    );
  }
}
