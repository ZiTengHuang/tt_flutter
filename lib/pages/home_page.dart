import 'package:flutter/material.dart';
import 'package:tt_flutter/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;

  List<Map> hotGoodsList = [];

  GlobalKey<RefreshFooterState> _footerkey = new GlobalKey<RefreshFooterState>();


  @override
  Widget build(BuildContext context) {
     // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('首页'),
        ),
        body: FutureBuilder(
          future: request('homePageContent',
              formdata: {'lon': '115.02932', 'lat': '35.76189'}),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //相当于转换成立 map  组合
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
              String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1 = (data['data']['floor1'] as List).cast();
              List<Map> floor2 = (data['data']['floor2'] as List).cast();
              List<Map> floor3 = (data['data']['floor3'] as List).cast();

              return  EasyRefresh(
                refreshFooter: ClassicsFooter(
                   key: _footerkey,
                   loadedText: '加载中',
                   noMoreText: '',
                   bgColor: Colors.white,
                   showMore: true,
                   moreInfo: '请求加载',
                   textColor: Colors.pink,
                   moreInfoColor: Colors.amber,
                   loadReadyText: '上啦加载',
                ),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(
                      swiperDataList: swiper,
                    ),
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    AdBanner(
                      adPicture: adPicture,
                    ),
                    LeaderPhone(
                      leaderImage: leaderImage,
                      leaderPhone: leaderPhone,
                    ),
                    Recommend(
                      recommendList: recommendList,
                    ),
                    FloorTitle(
                      picture_address: floor1Title,
                    ),
                    FloorContent(floorGoodsList: floor1),
                    FloorTitle(
                      picture_address: floor2Title,
                    ),
                    FloorContent(floorGoodsList: floor2),
                    FloorTitle(
                      picture_address: floor3Title,
                    ),
                    FloorContent(floorGoodsList: floor3),
                    _hotGoods(),
                  ],
                ),
                loadMore:() async{
                  _getHotGoods();
                 },
              );

            } else {
              return Center(
                child: new Text('加载中/////'),
              );
            }
          },
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _getHotGoods() {
    var formPage = {'page': page};
    request('homePageBelowConten', formdata: formPage).then((val) {
      print(val);
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();

      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  Widget hotTitle = new Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: new Text(
      '火爆专区',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),

    ),
    padding: EdgeInsets.all(5.0)
  );

  Widget _warpList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {},
          child: new Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: ScreenUtil().setSp(26),
                  ),
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                    Text('${val['mallPrice']}'),
                    Text(
                      '${val['price']}',
                      style: TextStyle(
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();
      return new Wrap(
         spacing: 2,
         children: listWidget,
      );
    }else{
       return new Text('');
    }
  }

  Widget _hotGoods(){
     return Container(
        child: Column(
          children: <Widget>[
             hotTitle,
             _warpList(),
          ],
        ),
     );
  }
}

// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '${swiperDataList[index]['image']}',
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 首页网格导航

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({this.navigatorList});

  Widget _gridViewItemUi(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了${item['mallCategoryId']}项');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUi(context, item);
        }).toList(),
      ),
    );
  }
}

// 首页广告条
class AdBanner extends StatelessWidget {
  final String adPicture;

  const AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image.network(
      adPicture,
    );
  }
}

// 首页店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;

  final String leaderPhone;

  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: _launcherURL,
      child: Image.network(leaderImage),
    );
  }

  void _launcherURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      //判断是否能发射出去
      await launch(url); //发射
    } else {
      throw 'url不正确、';
    }
  }
}

// 首页推荐列表
class Recommend extends StatelessWidget {
  final List recommendList;

  const Recommend({Key key, this.recommendList}) : super(key: key);

  //内部方法返回标题组件
  Widget _titleWidget() {
    return Container(
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  // 商品单独项方法

  Widget _item(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(320),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('${recommendList[index]['mallPrice']}'),
            Text(
              '${recommendList[index]['Price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // 横向列表方法
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(300),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _item(index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(360),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      ),
    );
  }
}

// 楼层标题
class FloorTitle extends StatelessWidget {
  final String picture_address;

  const FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品列表

class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[_firsRow(), _otherGoods()],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _firsRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        ),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('点击了楼层商品');

        },
        child: Image.network(goods['image']),
      ),
    );
  }
}

