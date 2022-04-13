import 'package:get/get.dart';
import 'package:nftmarketplace/utils/app_constants.dart';

import '../api/api_client.dart';

class RecommendedNftRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedNftRepo({required this.apiClient});

  Future<Response> getRecommendedNftList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_NFT_URI);
  }
}