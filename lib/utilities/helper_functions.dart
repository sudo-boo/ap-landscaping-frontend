import 'package:flutter/material.dart';

class Dimensions {
  late double _screenWidth;
  late double _screenHeight;

  Dimensions(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
  }

  double fractionWidth(double fraction) {
    return _screenWidth * fraction;
  }

  double fractionHeight(double fraction) {
    return _screenHeight * fraction;
  }
  double fractional(double measure, String dir){
    double _parent = 0;
    if(dir=='w'){
      _parent = _screenWidth;
    }else if(dir=='h'){
      _parent = _screenHeight;
    }else{
      throw Exception("Incorrect dimensional parameter");
    }
    return _parent*measure;
  }
  double percentWidth(double percent) {
    return _screenWidth * percent/100;
  }

  double percentHeight(double percent) {
    return _screenHeight * percent/100;
  }
  double percentage(double measure, String dir){
    double _parent = 0;
    if(dir=='w'){
      _parent = _screenWidth;
    }else if(dir=='h'){
      _parent = _screenHeight;
    }else{
      throw Exception("Incorrect dimensional parameter");
    }
    return _parent*measure/100;
  }
}

