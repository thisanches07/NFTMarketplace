import 'package:get/get.dart';
class Dimensions{
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight/2.03;
  static double pageViewContainer = screenHeight/3.15;
  static double pageViewTextContainer = screenHeight/5.5;

//dinamic height padding and margin
  static double height10 = screenHeight/69.2;
  static double height15 = screenHeight/46.14;
  static double height20 = screenHeight/34.6;
  static double height30 = screenHeight/23.06;
  static double height45 = screenHeight/15.37;

//dinamic width padding and margin
  static double width10 = screenHeight/69.2;
  static double width15 = screenHeight/46.14;
  static double width20 = screenHeight/34.6;
  static double width30 = screenHeight/23.06;

  static double font20 = screenHeight/42.2;

  //radius
  static double radius15 = screenHeight/46.13;
  static double radius20 = screenHeight/34.6;
  static double radius30 = screenHeight/20.06;
  static double radius50 = screenHeight/13.84;

  //icon size
  static double iconSize24 = screenHeight/28.9;

//list view size
  static double listViewImgSize = screenWidth/3;
  static double listViewTextContSize = screenWidth/3.45;

}