import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';
import 'signTabBar.dart';
import '../provide/sign.dart';
class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('丢雷'),
      ),
      body: Column(
        children: <Widget>[
          SignTabbar(),
          Provide<sign>(
            builder: (context,child,value){
              var isLeft =  Provide.value<sign>(context).isLeft;
              if(isLeft){
                return Center(
                  child: Text('登录界面'),
                );
              }else{
                return Center(
                  child: Text('注册界面'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

}

