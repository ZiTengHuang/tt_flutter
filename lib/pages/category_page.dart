import 'package:flutter/material.dart';
import 'package:tt_flutter/service/service_method.dart';
import 'dart:convert';

class CategoryPage extends StatefulWidget{
  _CategoryPageState createState()=> _CategoryPageState();

}

class _CategoryPageState extends State<CategoryPage>{
  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
       alignment: Alignment.center,
       child: Text('分类界面'),
    );
  }

  void _getCategory() async{
     await request('getCategory').then((val){
          var data =  json.decode(val);
          print(data);
     });
  }
}