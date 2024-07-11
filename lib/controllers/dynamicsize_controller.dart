import 'package:flutter/material.dart';

class DynamicSizeController {
  static double calculateAspectRatioSize(context, double percentage) {
    double screenHeight = MediaQuery.of(context).size.height,
        screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth * percentage + screenHeight * percentage) / 2;
  }

  static double calculateHeightSize(context, double percentage) {
    double screenHeight = MediaQuery.of(context).size.height;
    return (screenHeight * percentage);
  }

  static double calculateWidthSize(context, double percentage) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth * percentage);
  }

  static bool is16over9(BuildContext context) {
    double aspectRatio =
        MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    bool isMobile = aspectRatio < 0.8;

    return isMobile;
  }
}
