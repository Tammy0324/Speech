import 'package:flutter/material.dart';

import '../util/color_constant.dart';
import '../util/size_utils.dart';


class AppStyle {
  static TextStyle txtRobotoBold40 = TextStyle(
    color: ColorConstant.whiteA700,
    fontSize: getFontSize(
      40,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  static TextStyle txtRobotoBold36 = TextStyle(
    color: ColorConstant.gray100,
    fontSize: getFontSize(
      36,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  static TextStyle txtRobotoMedium24 = TextStyle(
    color: ColorConstant.gray800,
    fontSize: getFontSize(
      24,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );
}
