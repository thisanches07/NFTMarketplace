import 'package:get/get.dart';
import 'package:nftmarketplace/utils/app_constants.dart';

import '../api/api_client.dart';

class PopularNftRepo extends GetxService{
  final ApiClient apiClient;
  PopularNftRepo({required this.apiClient});

  Future<Response> getPopularNftList() async{
    return await apiClient.getData(AppConstants.POPULAR_NFT_URI);
  }
}