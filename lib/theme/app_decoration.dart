import 'package:flutter/material.dart';

import '../util/color_constant.dart';
import '../util/size_utils.dart';


class AppDecoration {
  static BoxDecoration get fillTeal50 => BoxDecoration(
        color: ColorConstant.teal50,
      );
  static BoxDecoration get txtFillTeal50 => BoxDecoration(
        color: ColorConstant.teal50,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder8 = BorderRadius.circular(
    getHorizontalSize(
      8.00,
    ),
  );

  static BorderRadius roundedBorder32 = BorderRadius.circular(
    getHorizontalSize(
      32.00,
    ),
  );

  static BorderRadius txtRoundedBorder8 = BorderRadius.circular(
    getHorizontalSize(
      8.00,
    ),
  );
}
