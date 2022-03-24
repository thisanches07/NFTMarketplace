import 'package:get/get.dart';

import '../api/api_client.dart';

class PopularNftRepo extends GetxService{
  final ApiClient apiClient;
  PopularNftRepo({required this.apiClient});

  Future<Response> getPopularNftList() async{
    return await apiClient.getData("https://www.marketplace.com/api/nft/list");
  }
}