import 'package:get/get.dart';
import 'package:nftmarketplace/pages/home/main_nft_page.dart';
import 'package:nftmarketplace/pages/nft/popular_nft_detail.dart';

import '../pages/nft/recommended_nft_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularNft = "/popular-fnt";
  static const String recommendedNft = "/recommended-fnt";

  static String getInitial()=>'$initial';
  static String getPopularNft(int pageId) => '$popularNft?pageId=$pageId';
  static String getRecommendedNft(int pageId) => '$recommendedNft?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainNFTPage()),
    GetPage(
        name: popularNft,
        page: () {
          var pageId=Get.parameters['pageId'];
          return PopularNftDetail(pageId:int.parse(pageId!));
        },
        transition:Transition.fadeIn
        ),
    GetPage(
        name: recommendedNft,
        page: () {
          var pageId=Get.parameters['pageId'];
          return RecommendedNftDetail(pageId:int.parse(pageId!));
        },
        transition:Transition.fadeIn
    )
  ];
}
