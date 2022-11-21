import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color bluegray600 = fromHex('#2f7694');

  static Color gray800 = fromHex('#4f4f4f');

  static Color blue400 = fromHex('#4fa0da');

  static Color teal50 = fromHex('#dfecf6');

  static Color whiteA700 = fromHex('#ffffff');

  static Color gray100 = fromHex('#f5f5f5');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
