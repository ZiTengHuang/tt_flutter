import 'package:flutter/material.dart';
import 'package:tt_flutter/pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';



void main(){
    var counter = Counter();
    var childCategory = ChildCategory();
    var categoryGoorlist = CategoryGoodsListProvide();
    var providers = Providers();
    providers
      ..provide(Provider<Counter>.value(counter))
      ..provide(Provider<ChildCategory>.value(childCategory))
      ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoorlist));
    runApp(ProviderNode(child: MyApp(), providers: providers));
} 

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
