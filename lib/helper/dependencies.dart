import 'package:get/get.dart';
import 'package:nftmarketplace/controllers/auth_controller.dart';
import 'package:nftmarketplace/controllers/cart_controller.dart';
import 'package:nftmarketplace/controllers/user_controller.dart';
import 'package:nftmarketplace/data/repository/auth_repo.dart';
import 'package:nftmarketplace/data/repository/cart_repo.dart';
import 'package:nftmarketplace/data/repository/user_repo.dart';
import 'package:nftmarketplace/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/popular_nft_controller.dart';
import '../controllers/recommended_nft_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/popular_nft_repo.dart';
import '../data/repository/recommended_nft_repo.dart';
Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //repository
  Get.lazyPut(() => PopularNftRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedNftRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(apiClient: Get.find(), sharedPreferences:Get.find()));

  //controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularNftController(popularNftRepo: Get.find()));
  Get.lazyPut(() => RecommendedNftController(recommendedNftRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}