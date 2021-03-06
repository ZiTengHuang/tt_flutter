import 'package:flutter/material.dart';
 import 'package:provide/provide.dart';
import '../provide/counter.dart';
import 'package:fluro/fluro.dart';
class CartPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: new AppBar(
          title: new Text('Provide 基础'),
       ),
       body: Center(
          child: Column(
             children: <Widget>[
               Number(),
               MyButton(),
             ],
          ),
       ),
    );
  }
}

class Number extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
       margin: EdgeInsets.only(top: 200),
       child: Provide<Counter>(builder:(context,child,counter){
          return Text('${counter.value}',style: Theme.of(context).textTheme.display1,);
       }),
    );
  }
}

class MyButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: RaisedButton(onPressed: (){
           Provide.value<Counter>(context).increment();
        },
          child: Text('递增'),
        ),

    );
  }
}