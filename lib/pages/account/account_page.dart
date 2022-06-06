import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/controllers/auth_controller.dart';
import 'package:nftmarketplace/controllers/cart_controller.dart';
import 'package:nftmarketplace/routes/route_helper.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/utils/dimensions.dart';
import 'package:nftmarketplace/widgets/account_widget.dart';
import 'package:nftmarketplace/widgets/app_icon.dart';
import 'package:nftmarketplace/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile", size: 24, color: Colors.white,
        ),
      ),
      body: Container(
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
                      bigText: BigText(text: "User test", )
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
                      bigText: BigText(text: "user.test@test.com", )
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
                      bigText: BigText(text: "+55 (15) 99999-9999", )
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
      ),
    );
  }
}