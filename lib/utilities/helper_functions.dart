import 'dart:math';

import 'package:flutter/material.dart';

// double fontHelper(BuildContext context){
//   double aspectRatio = ((screenWidth(context) + screenHeight(context)) * (screenWidth(context) + screenHeight(context)));
//   return sqrt(sqrt(sqrt(sqrt(sqrt(sqrt(sqrt(sqrt(aspectRatio))))))));
// }


double fontHelper(BuildContext context){
  // print(screenHeight(context));
  double aspectRatio = MediaQuery.of(context).size.height / 900;
  // print(aspectRatio);
  return aspectRatio;
}

// double fontHelper(BuildContext context){
//   return 1;
// }

double screenWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

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

