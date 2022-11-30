import 'package:flutter/material.dart';

import '../theme/app_style.dart';
import '../util/color_constant.dart';
import '../util/image_constant.dart';
import '../util/size_utils.dart';
import '../widgets/common_image_view.dart';

class Home1PageScreen extends StatefulWidget {
  Home1PageScreen({Key key,  this.title}) : super(key: key);

  final String title;

  @override
  Home1PageScreenState createState() => Home1PageScreenState();
}

class Home1PageScreenState extends State<Home1PageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      left: 18,
                      top: 78,
                      right: 18,
                    ),
                    child: CommonImageView(
                      imagePath: ImageConstant.imgEnglishpicture,
                      height: getVerticalSize(
                        248.00,
                      ),
                      width: getHorizontalSize(
                        251.00,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: getVerticalSize(
                      118.00,
                    ),
                    width: getHorizontalSize(
                      138.00,
                    ),
                    margin: getMargin(
                      left: 18,
                      top: 48,
                      right: 18,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                32.00,
                              ),
                            ),
                            child: CommonImageView(
                              imagePath: ImageConstant.imgBackground,
                              height: getVerticalSize(
                                118.00,
                              ),
                              width: getHorizontalSize(
                                138.00,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: getPadding(
                              left: 32,
                              top: 35,
                              right: 32,
                              bottom: 35,
                            ),
                            child: TextButton(
                              child: const Text(
                                "練習",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/audio',
                                    arguments: 0);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: getVerticalSize(
                      141.00,
                    ),
                    width: getHorizontalSize(
                      138.00,
                    ),
                    margin: getMargin(
                      left: 18,
                      top: 33,
                      right: 18,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                32.00,
                              ),
                            ),
                            child: CommonImageView(
                              imagePath: ImageConstant.imgBackground141x138,
                              height: getVerticalSize(
                                141.00,
                              ),
                              width: getHorizontalSize(
                                138.00,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: getHorizontalSize(
                              74.00,
                            ),
                            margin: getMargin(
                              left: 31,
                              top: 26,
                              right: 31,
                              bottom: 20,
                            ),
                            child: TextButton(
                              child: const Text(
                                "單字"+"\n"+"查詢",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/words',
                                    arguments: 0);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: getPadding(
                //       left: 18,
                //       top: 23,
                //       right: 18,
                //       bottom: 5,
                //     ),
                //     child: CommonImageView(
                //       imagePath: ImageConstant.imgBackbotton,
                //       height: getSize(
                //         80.00,
                //       ),
                //       width: getSize(
                //         80.00,
                //       ),
                //     ),
                //   ),
                // ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: getPadding(
                //       left: 18,
                //       top: 23,
                //       right: 18,
                //       bottom: 5,
                //     ),
                //     child: IconButton(
                //       icon: Image.asset('assets/images/img_backbotton.png',height: 300,width: 300,fit:BoxFit.cover),
                //       onPressed: () {
                //         Navigator.pushNamed(context, '/', arguments: 0);
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       backgroundColor: ColorConstant.whiteA700,
  //       body: Container(
  //         width: size.width,
  //         child: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Padding(
  //                   padding: getPadding(
  //                     left: 13,
  //                     top: 25,
  //                     right: 13,
  //                   ),
  //                   child: CommonImageView(
  //                     height: getSize(
  //                       67.00,
  //                     ),
  //                     width: getSize(
  //                       67.00,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.center,
  //                 child: Padding(
  //                   padding: getPadding(
  //                     left: 13,
  //                     top: 8,
  //                     right: 13,
  //                   ),
  //                   child: CommonImageView(
  //                     imagePath: ImageConstant.imgEnglishpicture,
  //                     height: getVerticalSize(
  //                       241.00,
  //                     ),
  //                     width: getHorizontalSize(
  //                       243.00,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.center,
  //                 child: Padding(
  //                   padding: getPadding(
  //                     left: 13,
  //                     top: 41,
  //                     right: 13,
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisSize: MainAxisSize.max,
  //                     children: [
  //                       Container(
  //                         height: getVerticalSize(
  //                           125.00,
  //                         ),
  //                         width: getHorizontalSize(
  //                           139.00,
  //                         ),
  //                         child: Stack(
  //                           alignment: Alignment.center,
  //                           children: [
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: ClipRRect(
  //                                 borderRadius: BorderRadius.circular(
  //                                   getHorizontalSize(
  //                                     32.00,
  //                                   ),
  //                                 ),
  //                                 child: CommonImageView(
  //                                   imagePath: ImageConstant.imgBackground,
  //                                   height: getVerticalSize(
  //                                     125.00,
  //                                   ),
  //                                   width: getHorizontalSize(
  //                                     139.00,
  //                                   ),
  //                                   fit: BoxFit.cover,
  //                                 ),
  //                               ),
  //                             ),
  //                             Align(
  //                               alignment: Alignment.center,
  //                               child: Padding(
  //                                 padding: getPadding(
  //                                   top: 20,
  //                                   left: 32,
  //                                   right: 31,
  //                                   bottom: 20,
  //                                 ),
  //                                 child: TextButton(
  //                                   child: Text(
  //                                     "練習",
  //                                     overflow: TextOverflow.ellipsis,
  //                                     textAlign: TextAlign.left,
  //                                     style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontSize: 25.0,
  //                                     ),
  //                                   ),
  //                                   onPressed: () {
  //                                     Navigator.pushNamed(context, '/audio',
  //                                         arguments: 0);
  //                                   },
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       Container(
  //                         height: getVerticalSize(
  //                           125.00,
  //                         ),
  //                         width: getHorizontalSize(
  //                           139.00,
  //                         ),
  //                         child: Stack(
  //                           alignment: Alignment.center,
  //                           children: [
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: ClipRRect(
  //                                 borderRadius: BorderRadius.circular(
  //                                   getHorizontalSize(
  //                                     32.00,
  //                                   ),
  //                                 ),
  //                                 child: CommonImageView(
  //                                   imagePath: ImageConstant.imgBackground,
  //                                   height: getVerticalSize(
  //                                     125.00,
  //                                   ),
  //                                   width: getHorizontalSize(
  //                                     139.00,
  //                                   ),
  //                                   fit: BoxFit.cover,
  //                                 ),
  //                               ),
  //                             ),
  //                             Align(
  //                               alignment: Alignment.center,
  //                               child: Padding(
  //                                 padding: getPadding(
  //                                   top: 20,
  //                                   left: 32,
  //                                   right: 31,
  //                                   bottom: 20,
  //                                 ),
  //                                 child: TextButton(
  //                                   child: Text(
  //                                     "單字"+"\n"+"查詢",
  //                                     overflow: TextOverflow.ellipsis,
  //                                     textAlign: TextAlign.left,
  //                                     style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontSize: 25.0,
  //                                     ),
  //                                   ),
  //                                   onPressed: () {
  //                                     Navigator.pushNamed(context, '/word',
  //                                         arguments: 0);
  //                                   },
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Padding(
  //                   padding: getPadding(
  //                     left: 18,
  //                     top: 200,
  //                     right: 18,
  //                     bottom: 5,
  //                   ),
  //                   child: IconButton(
  //                     icon: new Image.asset('assets/images/img_backbotton.png'),
  //                     onPressed: () {
  //                       Navigator.pushNamed(context, '/', arguments: 0);
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
