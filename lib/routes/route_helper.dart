import 'package:get/get.dart';
import 'package:nftmarketplace/pages/home/main_nft_page.dart';
import 'package:nftmarketplace/pages/nft/popular_nft_detail.dart';

import '../pages/nft/recommended_nft_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularNft = "/popular-fnt";
  static const String recommendedNft = "/recommended-fnt";

  static String getInitial()=>'$initial';
  static String getPopularNft() => '$popularNft';
  static String getRecommendedNft() => '$recommendedNft';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainNFTPage()),
    GetPage(
        name: popularNft,
        page: () {
          return PopularNftDetail();
        },
        transition:Transition.fadeIn
        ),
    GetPage(
        name: recommendedNft,
        page: () {
          return RecommendedNftDetail();
        },
        transition:Transition.fadeIn
    )
  ];
}
