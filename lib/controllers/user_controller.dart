import 'package:get/get.dart';
import 'package:nftmarketplace/data/repository/user_repo.dart';
import 'package:nftmarketplace/models/response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> getUserInfo() async {
    _isLoading=true;
    update();
    Response response = await userRepo.getUserInfo();
    late  ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  // Future<ResponseModel> signIn(String username, String password) async {
  //   userRepo.getUserToken();
  //   _isLoading=true;
  //   update();
  //   Response response = await userRepo.signIn(username, password);
  //   late  ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     userRepo.saveUserToken(response.body["token"]);
  //     responseModel = ResponseModel(true, response.body["token"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText!);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // void saveUserNumberAndPassword(String number, String password) {
  //   userRepo.saveUserNumberAndPassword(number, password);
  // }

  // bool userLoggedIn(){
  //   return userRepo.userLoggedIn();
  // }

  // bool clearSharedData(){
  //   return userRepo.clearSharedData();
  // }
}