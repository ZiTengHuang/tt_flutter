import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: new Icon(CupertinoIcons.home), title: new Text('首页')),
    BottomNavigationBarItem(
        icon: new Icon(Icons.search), title: new Text('分类')),
    BottomNavigationBarItem(
        icon: new Icon(Icons.shopping_cart), title: new Text('购物车')),
    BottomNavigationBarItem(
        icon: new Icon(Icons.person_pin), title: new Text('会员中心')),
  ];

  final List tabBodies = [HomePage(), CategoryPage(), CartPage(), MemberPage()];

  int currentIndex = 0;

  var currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage = tabBodies[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: new Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: currentPage,
    );
  }
}
