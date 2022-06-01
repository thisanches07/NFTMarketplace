import 'package:get/get.dart';
import 'package:nftmarketplace/data/api/api_client.dart';
import 'package:nftmarketplace/models/signup_body_model.dart';
import 'package:nftmarketplace/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.USERS_URI, signUpBody.toJson());
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
}