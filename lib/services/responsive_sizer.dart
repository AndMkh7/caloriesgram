import 'package:flutter/material.dart';

class ResponsiveSizer {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  static double verticalScale(double figmaHeight) {
    return screenHeight * figmaHeight / 812;
  }

  static double horizontalScale(double figmaWidth) {
    return screenWidth * figmaWidth / 375;
  }

  static double moderateScale(double size, [double factor = 0.5]) {
    return size + (horizontalScale(size) - size) * factor;
  }
}
