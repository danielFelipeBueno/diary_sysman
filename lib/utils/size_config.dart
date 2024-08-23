

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:io';
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static double? aspectRatio;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    aspectRatio = _mediaQueryData!.size.aspectRatio;
    orientation = _mediaQueryData!.orientation;
  }
}

double getAspectRatio(){
  return SizeConfig.aspectRatio!;
}

double getAvailableHeight(double size){
  double deadZone = Platform.isAndroid
  ?0.97:getAspectRatio() > 0.5?0.97:0.89;
  double? screenHeight = SizeConfig.screenHeight;
  return (screenHeight!*deadZone) * size;
}

double getAvailableWidth(double size) {
  double? screenWidth = SizeConfig.screenWidth;
  return screenWidth! * size;
}