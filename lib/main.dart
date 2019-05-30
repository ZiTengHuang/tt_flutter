import 'package:flutter/material.dart';
import 'package:tt_flutter/pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/sign.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categoryGoorlist = CategoryGoodsListProvide();
  var providers = Providers();
  var sign2 = sign();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<sign>.value(sign2))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoorlist));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String debugLable = 'Unkown';
  final JPush jpush = new JPush();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print('>>>>>>>>>>>>>>>>>>>fluter接受到推送${message}');
        setState(() {
          debugLable = "接受到推送${message}";
        });
      });
    } on PlatformException {
      platformVersion = '平台版本获取失败请，检查';
    }

    ///如果没有错误这个方法直接OK，并且结束
    if (!mounted) return;
    setState(() {
      debugLable = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(primaryColor: Colors.pink),
//        home: IndexPage(),
        home: Scaffold(

          body: Container(
            child: Column(
              children: <Widget>[
                Text('结果 : ${debugLable}'),
                FlatButton(
                  child: Text('发送推送消息'),
                  onPressed: () {
                    ///延迟三秒
                    var fireDate = DateTime.fromMillisecondsSinceEpoch(
                        DateTime.now().millisecondsSinceEpoch + 3000);
                    var localNotification = LocalNotification(
                      id: 123,
                      title: '小黄的飞鸽传书',
                      buildId: 1,
                      content: '看到说明成功了',
                      fireTime: fireDate,
                      subtitle: '一个测试',
                    );
                    jpush.sendLocalNotification(localNotification).then((res){
                      setState(() {
                        debugLable = res;
                      });
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
