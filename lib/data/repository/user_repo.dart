import 'package:get/get.dart';
import 'package:nftmarketplace/data/api/api_client.dart';
import 'package:nftmarketplace/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({
    required this.apiClient
  });

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USERS_URI);
  }
}