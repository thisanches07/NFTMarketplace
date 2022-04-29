import 'package:get/get.dart';
import 'package:nftmarketplace/controllers/cart_controller.dart';
import 'package:nftmarketplace/data/repository/cart_repo.dart';
import 'package:nftmarketplace/utils/app_constants.dart';
import '../controllers/popular_nft_controller.dart';
import '../controllers/recommended_nft_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/popular_nft_repo.dart';
import '../data/repository/recommended_nft_repo.dart';
Future<void> init() async{
  //api client
  Get.lazyPut(()=> ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repository
  Get.lazyPut(() => PopularNftRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedNftRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  //controller
  Get.lazyPut(() => PopularNftController(popularNftRepo: Get.find()));
  Get.lazyPut(() => RecommendedNftController(recommendedNftRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}