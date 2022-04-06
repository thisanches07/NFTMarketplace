import 'package:get/get.dart';
import '../controllers/popular_nft_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/popular_nft_repo.dart';
Future<void> init() async{
  //api client
  Get.lazyPut(()=> ApiClient(appBaseUrl: "https://nftsmarketplace.herokuapp.com"));

  //repository
  Get.lazyPut(() => PopularNftRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => PopularNftController(popularNftRepo: Get.find()));

}