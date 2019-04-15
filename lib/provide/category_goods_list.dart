import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide extends ChangeNotifier{

    List<CategoryListData> goodsList=[];

    //点击大类更换商品列表

    getCategoryGoodsList(List<CategoryListData> list){
        goodsList = list;
        notifyListeners();
    }
}
