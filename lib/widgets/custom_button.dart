import 'package:flutter/material.dart';

import '../util/color_constant.dart';
import '../util/size_utils.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.onTap,
      this.width,
      this.margin,
      this.prefixWidget,
      this.suffixWidget,
      this.text});

  ButtonShape shape;

  ButtonPadding padding;

  ButtonVariant variant;

  ButtonFontStyle fontStyle;

  Alignment alignment;

  VoidCallback onTap;

  double width;

  EdgeInsetsGeometry margin;

  Widget prefixWidget;

  Widget suffixWidget;

  String text;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: getHorizontalSize(width ?? 0),
        margin: margin,
        padding: _setPadding(),
        decoration: _buildDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixWidget ?? SizedBox(),
            Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: _setFontStyle(),
            ),
            suffixWidget ?? SizedBox(),
          ],
        ),
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      borderRadius: _setBorderRadius(),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll16:
        return getPadding(
          all: 16,
        );
      case ButtonPadding.PaddingAll9:
        return getPadding(
          all: 9,
        );
      default:
        return getPadding(
          all: 19,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.FillBluegray600:
        return ColorConstant.bluegray600;
      default:
        return ColorConstant.teal50;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.RoundedBorder8:
        return BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        );
      case ButtonShape.CircleBorder33:
        return BorderRadius.circular(
          getHorizontalSize(
            33.00,
          ),
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            20.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.RobotoMedium24:
        return TextStyle(
          color: ColorConstant.gray800,
          fontSize: getFontSize(
            24,
          ),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        );
      case ButtonFontStyle.RobotoMedium40:
        return TextStyle(
          color: ColorConstant.gray800,
          fontSize: getFontSize(
            40,
          ),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        );
      default:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder20,
  RoundedBorder8,
  CircleBorder33,
}

enum ButtonPadding {
  PaddingAll19,
  PaddingAll16,
  PaddingAll9,
}

enum ButtonVariant {
  FillBluegray600,
  FillTeal50,
}

enum ButtonFontStyle {
  RobotoMedium18,
  RobotoMedium24,
  RobotoMedium40,
}
