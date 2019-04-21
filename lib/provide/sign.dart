import 'package:flutter/material.dart';

class sign with ChangeNotifier{
    bool isLeft = true;
    bool isRight = false;

    changeLeftAndRight(String changeState){
        if(changeState=='left'){
           isLeft = true;
           isRight = false;
        }else{
           isLeft = false;
           isRight = true;
        }
        notifyListeners();
    }
}