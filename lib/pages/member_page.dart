import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class MemberPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
//        child: Provide<Counter>(builder:(context,child,counter){
//                return Text('${counter.value}');
//        }),
         child: _FormField(),
      ),
    );
  }


  Widget _FormField(){
      return Container(
        height: 400,
        margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: Column(
           children: <Widget>[
              _FormSubTitle(),
              RoundFormField(),
           ],
        ),
      );
  }
}

  Widget _FormSubTitle(){
   return Container(
         alignment: Alignment.centerLeft,
        child: Text('手机号',
          style: TextStyle(
             fontSize: 21,
                 color: Colors.pink,
          ),
        ),
   );
}

/// 自定义的圆框表单字段组件。
class RoundFormField extends StatefulWidget {
  /// 字段内的提示文字。
  final String hintText;
  /// 文本字段的控制器。
  final TextEditingController textEditingController;
  /// 文本字段修改时的回调函数。
  final Function checkCallback;

  RoundFormField({
    this.hintText,
    this.textEditingController,
    this.checkCallback,
  });

  @override
  _RoundFormFieldState createState() => _RoundFormFieldState();
}

/// 与自定义的圆框表单字段组件关联的状态子类。
class _RoundFormFieldState extends State<RoundFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Color(0xff333333),
        // 边界（`border`）属性，要在背景颜色、渐变或图像上方绘制的边框。
        border: Border.all(
          width: 1.0,
          color: Color(0xFF4A4A4A),
          style: BorderStyle.solid,
        ),
        // 边界半径（`borderRadius`）属性，对此容器框的角进行舍入。
        borderRadius:   BorderRadius.circular(20.0),
      ),
      // TODO: 第3步：实现“文本输入框”
      // TODO: 第3步：实现“文本输入框”
        child: TextField(

          // 控制器属性，控制正在编辑的文本。
          controller: widget.textEditingController,
          // 光标颜色属性，绘制光标时使用的颜色。
          cursorColor: const Color(0xFFFF6B47),
          // 光标宽度属性，光标的厚度，默认是2.0。
          cursorWidth: 1.0,
          // 样式属性，用于正在编辑的文本的样式。
          style: TextStyle(
            color: Color(0xFF4A4A4A),
            fontSize: 16.0,
          ),
          // 装饰（`decoration`）属性，在文本字段周围显示的装饰。
          decoration: InputDecoration(

            // 边框属性，装饰的容器周围绘制的形状。
            border: InputBorder.none,
            // 填充颜色属性，填充装饰容器的颜色。
            fillColor: const Color(0xff333333),
            // 是密集属性，输入子项是否是密集形式的一部分（即使用较少的垂直空间）。
            isDense: true,
            // 填充属性，如果为`true`，则装饰的容器将填充fillColor颜色。
            filled: true,

            // 提示样式属性，用于提示文本（`hintText`）的样式。
            hintStyle: TextStyle(
              color: Color(0xFF9B9B9B),
              fontSize: 16.0,
            ),
            // 提示文本属性，提示字段接受哪种输入的文本。
            hintText: widget.hintText,
          ),
          // 在改变属性，当正在编辑的文本发生更改时调用。
          onChanged: (value) {
            // 每次修改字段文本时都会调用一次。
            widget.checkCallback(value);
          },
        ),
    );
  }
}
