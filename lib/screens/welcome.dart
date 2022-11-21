import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_style.dart';
import '../util/color_constant.dart';
import '../util/image_constant.dart';
import '../util/size_utils.dart';
import '../widgets/common_image_view.dart';
import '../widgets/custom_button.dart';

class WelcomePage extends StatefulWidget {

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.blue400,
            body: Container(
              //  width: size.width,
                child: SingleChildScrollView(
                    child: Container(
                        //height: size.height,
                        //width: size.width,
                        child: Stack(alignment: Alignment.topCenter, children: [
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                  height: getVerticalSize(782.00),
                                  width: getHorizontalSize(345.00),
                                  margin: getMargin(
                                      left: 15, top: 15, right: 15, bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          getHorizontalSize(32.00)),
                                      gradient: LinearGradient(
                                          begin: Alignment(0.7869565623820254,
                                              0.1592071696639642),
                                          end: Alignment(4.763474059643613e-9,
                                              1.026854241520399),
                                          colors: [
                                            ColorConstant.blue400,
                                            ColorConstant.blue400
                                          ])))),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                  padding: getPadding(
                                      left: 30, top: 52, right: 30, bottom: 52),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                                padding: getPadding(right: 5),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                              padding:
                                                                  getPadding(
                                                                      right: 6),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            top:
                                                                                164,
                                                                            bottom:
                                                                                46),
                                                                        child: CommonImageView(
                                                                            svgPath:
                                                                                ImageConstant.imgStar,
                                                                            height: getVerticalSize(8.00),
                                                                            width: getHorizontalSize(9.00))),
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            top:
                                                                                64,
                                                                            bottom:
                                                                                63),
                                                                        child: Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Align(alignment: Alignment.centerLeft, child: Padding(padding: getPadding(right: 3), child: CommonImageView(svgPath: ImageConstant.imgArrowright, height: getSize(26.00), width: getSize(26.00)))),
                                                                              Padding(padding: getPadding(left: 10, top: 47), child: CommonImageView(svgPath: ImageConstant.imgSettings, height: getVerticalSize(17.00), width: getHorizontalSize(14.00)))
                                                                            ])),
                                                                    Container(
                                                                        height: getVerticalSize(
                                                                            219.00),
                                                                        width: getHorizontalSize(
                                                                            104.00),
                                                                        child: Stack(
                                                                            alignment:
                                                                                Alignment.bottomRight,
                                                                            children: [
                                                                              Align(
                                                                                  alignment: Alignment.centerRight,
                                                                                  child: Padding(
                                                                                      padding: getPadding(left: 10, top: 56, right: 7, bottom: 56),
                                                                                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                                                                        Padding(padding: getPadding(top: 59, bottom: 34), child: CommonImageView(svgPath: ImageConstant.imgStar, height: getVerticalSize(8.00), width: getHorizontalSize(9.00))),
                                                                                        Padding(
                                                                                            padding: getPadding(left: 17),
                                                                                            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                              Align(alignment: Alignment.centerRight, child: Padding(padding: getPadding(left: 2), child: CommonImageView(svgPath: ImageConstant.imgTicket, height: getSize(24.00), width: getSize(24.00)))),
                                                                                              Padding(padding: getPadding(top: 68, right: 10), child: CommonImageView(svgPath: ImageConstant.imgStar, height: getVerticalSize(8.00), width: getHorizontalSize(9.00)))
                                                                                            ])),
                                                                                        Padding(padding: getPadding(left: 16, top: 68, bottom: 15), child: CommonImageView(svgPath: ImageConstant.imgSignal, height: getVerticalSize(18.00), width: getHorizontalSize(9.00)))
                                                                                      ]))),
                                                                              Align(alignment: Alignment.bottomRight, child: Padding(padding: getPadding(left: 11, top: 10, right: 11), child: CommonImageView(svgPath: ImageConstant.imgSort, height: getVerticalSize(21.00), width: getHorizontalSize(16.00)))),
                                                                              Align(alignment: Alignment.topLeft, child: Padding(padding: getPadding(top: 42, right: 10, bottom: 42), child: CommonImageView(svgPath: ImageConstant.imgStar, height: getSize(12.00), width: getSize(12.00)))),
                                                                              Align(alignment: Alignment.topLeft, child: Padding(padding: getPadding(bottom: 10), child: CommonImageView(svgPath: ImageConstant.imgBulb, height: getVerticalSize(206.00), width: getHorizontalSize(104.00))))
                                                                            ])),
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            top:
                                                                                23,
                                                                            bottom:
                                                                                9),
                                                                        child: Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Align(alignment: Alignment.centerRight, child: Padding(padding: getPadding(left: 43, right: 43), child: CommonImageView(svgPath: ImageConstant.imgFolder, height: getSize(19.00), width: getSize(19.00)))),
                                                                              Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Padding(
                                                                                      padding: getPadding(top: 1, right: 10),
                                                                                      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, mainAxisSize: MainAxisSize.max, children: [
                                                                                        CommonImageView(svgPath: ImageConstant.imgRewind, height: getVerticalSize(23.00), width: getHorizontalSize(9.00)),
                                                                                        Padding(padding: getPadding(left: 65, top: 12, bottom: 2), child: CommonImageView(svgPath: ImageConstant.imgStar, height: getSize(9.00), width: getSize(9.00)))
                                                                                      ]))),
                                                                              Align(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Padding(
                                                                                      padding: getPadding(top: 35, right: 10),
                                                                                      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                                                                        Padding(padding: getPadding(top: 5), child: CommonImageView(svgPath: ImageConstant.imgVector, height: getVerticalSize(18.00), width: getHorizontalSize(16.00))),
                                                                                        Padding(padding: getPadding(left: 51, bottom: 5), child: CommonImageView(svgPath: ImageConstant.imgSettings, height: getVerticalSize(18.00), width: getHorizontalSize(15.00)))
                                                                                      ]))),
                                                                              Align(
                                                                                  alignment: Alignment.centerRight,
                                                                                  child: Padding(
                                                                                      padding: getPadding(left: 38, top: 15, right: 4),
                                                                                      child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                                                                        Padding(padding: getPadding(top: 3), child: CommonImageView(svgPath: ImageConstant.imgVector, height: getVerticalSize(18.00), width: getHorizontalSize(14.00))),
                                                                                        Padding(padding: getPadding(left: 36, bottom: 9), child: CommonImageView(svgPath: ImageConstant.imgRewind, height: getVerticalSize(11.00), width: getHorizontalSize(22.00)))
                                                                                      ]))),
                                                                              Align(alignment: Alignment.centerRight, child: Padding(padding: getPadding(left: 10, top: 17), child: CommonImageView(svgPath: ImageConstant.imgStar, height: getSize(9.00), width: getSize(9.00)))),
                                                                              Align(alignment: Alignment.centerRight, child: Padding(padding: getPadding(left: 31, top: 2, right: 31), child: CommonImageView(svgPath: ImageConstant.imgQuestion, height: getVerticalSize(17.00), width: getHorizontalSize(10.00))))
                                                                            ]))
                                                                  ]))),
                                                      Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                              padding:
                                                                  getPadding(
                                                                      left: 3,
                                                                      top: 10),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Padding(
                                                                              padding: getPadding(bottom: 21),
                                                                              child: CommonImageView(svgPath: ImageConstant.imgMinimize, height: getVerticalSize(8.00), width: getHorizontalSize(11.00))),
                                                                          Padding(
                                                                              padding: getPadding(left: 36, top: 8),
                                                                              child: CommonImageView(svgPath: ImageConstant.imgSort, height: getVerticalSize(22.00), width: getHorizontalSize(18.00))),
                                                                          Padding(
                                                                              padding: getPadding(left: 29, top: 5, bottom: 12),
                                                                              child: CommonImageView(svgPath: ImageConstant.imgStar, height: getSize(12.00), width: getSize(12.00)))
                                                                        ]),
                                                                    Padding(
                                                                        padding: getPadding(
                                                                            top:
                                                                                8,
                                                                            bottom:
                                                                                9),
                                                                        child: CommonImageView(
                                                                            svgPath:
                                                                                ImageConstant.imgStar,
                                                                            height: getSize(12.00),
                                                                            width: getSize(12.00)))
                                                                  ]))),
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                              padding:
                                                                  getPadding(
                                                                      left: 108,
                                                                      top: 37,
                                                                      right:
                                                                          108),
                                                              child: CommonImageView(
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgStar,
                                                                  height:
                                                                      getSize(
                                                                          12.00),
                                                                  width: getSize(
                                                                      12.00)))),
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                              padding:
                                                                  getPadding(
                                                                      left: 64,
                                                                      top: 1,
                                                                      right:
                                                                          64),
                                                              child: CommonImageView(
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgStar,
                                                                  height:
                                                                      getSize(
                                                                          9.00),
                                                                  width: getSize(
                                                                      9.00)))),
                                                      Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Padding(
                                                              padding:
                                                                  getPadding(
                                                                      left: 114,
                                                                      top: 9,
                                                                      right:
                                                                          114),
                                                              child: CommonImageView(
                                                                  svgPath:
                                                                      ImageConstant
                                                                          .imgVectorTeal900,
                                                                  height:
                                                                      getVerticalSize(
                                                                          4.00),
                                                                  width: getHorizontalSize(
                                                                      14.00))))
                                                    ]))),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                width:
                                                    getHorizontalSize(163.00),
                                                margin: getMargin(
                                                    left: 80,
                                                    top: 97,
                                                    right: 70),
                                                child: Text("Happy Learning".tr,
                                                    maxLines: null,
                                                    textAlign: TextAlign.center,
                                                    style: AppStyle
                                                        .txtRobotoBold40))),
                                        CustomButton(
                                            width: 314,
                                            text: "Get Started".tr,
                                            onTap: () {
                                              Navigator.pushNamed(context, '/home',arguments: 0);
                                            },
                                            margin: getMargin(top: 69),
                                            variant:
                                                ButtonVariant.FillBluegray600)
                                      ]))),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                  padding: getPadding(
                                      left: 19,
                                      top: 224,
                                      right: 19,
                                      bottom: 224),
                                  child: CommonImageView(
                                      svgPath: ImageConstant.imgBook,
                                      height: getVerticalSize(189.00),
                                      width: getHorizontalSize(336.00))))
                        ]))))));
  }
}
