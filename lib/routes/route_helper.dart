import 'package:get/get.dart';
import 'package:nftmarketplace/pages/cart/cart_page.dart';
import 'package:nftmarketplace/pages/nft/popular_nft_detail.dart';

import '../pages/home/home_page.dart';
import '../pages/nft/recommended_nft_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularNft = "/popular-fnt";
  static const String recommendedNft = "/recommended-fnt";
  static const String cartPage = '/cart-page';

  static String getInitial()=>'$initial';
  static String getPopularNft(int pageId,String page) => '$popularNft?pageId=$pageId&page=$page';
  static String getRecommendedNft(int pageId,String page) => '$recommendedNft?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: popularNft,
        page: () {
          var pageId=Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return PopularNftDetail(pageId:int.parse(pageId!), page:page!);
        },
        transition:Transition.fadeIn
        ),
    GetPage(
        name: recommendedNft,
        page: () {
          var pageId=Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return RecommendedNftDetail(pageId:int.parse(pageId!),page:page!);
        },
        transition:Transition.fadeIn
    ),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
    transition: Transition.fadeIn)
  ];
}
