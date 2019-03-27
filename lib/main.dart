import 'package:flutter/material.dart';
import 'package:tt_flutter/pages/index_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new MaterialApp(
          title: '百姓生活+',
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(
             primaryColor: Colors.pink
          ),
          home: IndexPage(),
      ),
    );
  }
}
