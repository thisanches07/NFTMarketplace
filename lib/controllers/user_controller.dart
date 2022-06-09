import 'package:get/get.dart';
import 'package:nftmarketplace/controllers/auth_controller.dart';
import 'package:nftmarketplace/data/repository/user_repo.dart';
import 'package:nftmarketplace/models/response_model.dart';
import 'package:nftmarketplace/models/user_model.dart';
import 'package:nftmarketplace/routes/route_helper.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  UserModel? _userModel;

  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    print(response.body.toString());
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      Get.find<AuthController>().clearSharedData();
      _isLoading = true;
      responseModel = ResponseModel(false, response.body["message"]!);
    }
    update();
    return responseModel;
  }
}