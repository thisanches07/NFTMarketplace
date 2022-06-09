import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/base/custom_loader.dart';
import 'package:nftmarketplace/controllers/auth_controller.dart';
import 'package:nftmarketplace/controllers/cart_controller.dart';
import 'package:nftmarketplace/controllers/user_controller.dart';
import 'package:nftmarketplace/models/response_model.dart';
import 'package:nftmarketplace/models/user_model.dart';
import 'package:nftmarketplace/routes/route_helper.dart';
import 'package:nftmarketplace/utils/app_constants.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/utils/dimensions.dart';
import 'package:nftmarketplace/widgets/account_widget.dart';
import 'package:nftmarketplace/widgets/app_icon.dart';
import 'package:nftmarketplace/widgets/big_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPage createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
  
  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();

    Future<void> _getUserData() async {
      var response = await Get.find<UserController>().getUserInfo();
      if(!response.isSuccess){
        Get.find<AuthController>().clearSharedData();
      }
    }

    _getUserData();
    
    if(_userLoggedIn){
      print("User has logged in");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile", size: 24, color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn && userController.userModel != null ? (userController.isLoading ?
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimensions.height20),
            child: Column(
              children: [
                AppIcon(
                  icon: Icons.person,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.height45 + Dimensions.height30,
                  iconColor: Colors.white,
                  size: Dimensions.height15 * 10,
                ),
                SizedBox(height: Dimensions.height30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // User
                        AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconSize: Dimensions.height10*5/2,
                            iconColor: Colors.white,
                            size: Dimensions.height10 * 5,
                          ), 
                          bigText: BigText(text: userController.userModel!.name, )
                        ),
                        SizedBox(height: Dimensions.height20),
                        // Email
                        AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.email,
                            backgroundColor: Colors.grey,
                            iconSize: Dimensions.height10*5/2,
                            iconColor: Colors.white,
                            size: Dimensions.height10 * 5,
                          ), 
                          bigText: BigText(text: userController.userModel!.username, )
                        ),
                        SizedBox(height: Dimensions.height20),
                        // Phone
                        AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.phone,
                            backgroundColor: Colors.grey,
                            iconSize: Dimensions.height10*5/2,
                            iconColor: Colors.white,
                            size: Dimensions.height10 * 5,
                          ), 
                          bigText: BigText(text: userController.userModel!.phone, )
                        ),
                        SizedBox(height: Dimensions.height20),
                        // Logout
                        GestureDetector(
                          onTap: (){
                            if(Get.find<AuthController>().userLoggedIn()){
                              Get.find<AuthController>().clearSharedData();
                              Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();
                              Get.offNamed(RouteHelper.getSignInPage());
                            } else {
                              print("You logged out!");
                            }
                          },
                          child: AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.logout,
                              backgroundColor: Colors.red,
                              iconSize: Dimensions.height10*5/2,
                              iconColor: Colors.white,
                              size: Dimensions.height10 * 5,
                            ), 
                            bigText: BigText(text: "Logout", )
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ):
          CustomLoader()
        ):
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                    "assets/image/NFTLogo1.png"
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Text(
                    "You must login",
                    style: TextStyle(
                        fontSize: Dimensions.font16*3,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor
                    ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                GestureDetector(
                  onTap: (){
                    Get.offNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                    ),
                    child: Center (
                      child: BigText(
                        text: "Sign In",
                        size: Dimensions.font20+Dimensions.font20/2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ]),
          ),
        );
      }),
    );
  }
}