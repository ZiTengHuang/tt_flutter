import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/sign.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Provide<sign>(
      builder: (context, child, value) {
        var isLeft = Provide.value<sign>(context).isLeft;
        var isRight = Provide.value<sign>(context).isRight;
        return Container(
          child: Row(
              children: <Widget>[
              _myTabBarLeft(context,isLeft),
              _myTabBarRight(context,isRight),
          ],
        ),
        );
      },
    );
  }

  Widget _myTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<sign>(context).changeLeftAndRight('left');
      },
      child: Container(
        child: Text(
          '登录',
          style: TextStyle(
            fontSize: isLeft ? ScreenUtil().setSp(50) : ScreenUtil().setSp(20),
            color: isLeft?Colors.pink:Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _myTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<sign>(context).changeLeftAndRight('right');
      },
      child: Container(
        child: Text(
          '注册',
          style: TextStyle(
            fontSize: isRight ? ScreenUtil().setSp(50) : ScreenUtil().setSp(20),
            color: isRight?Colors.pink:Colors.black,

          ),
        ),
      ),
    );
  }
}
