import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/base/custom_loader.dart';
import 'package:nftmarketplace/base/no_data_page.dart';
import 'package:nftmarketplace/base/show_custom_message.dart';
import 'package:nftmarketplace/controllers/auth_controller.dart';
import 'package:nftmarketplace/models/response_model.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/widgets/app_icon.dart';
import 'package:nftmarketplace/widgets/big_text.dart';
import 'package:nftmarketplace/widgets/small_text.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_nft_controller.dart';
import '../../controllers/recommended_nft_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPage createState() => _CartPage();

}
class _CartPage extends State<CartPage> {

  Future<void> sendData(CartController controller) async{
    controller.addToHistory();
    ResponseModel response = await controller.addItemToOrderList();
    if (!response.isSuccess){
      showCustomSnackBar(response.message, title: "Order");
    } else {
      showCustomSnackBar(response.message, isError: false, title: "Order");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height20 + 10,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAndToNamed(Get.previousRoute);
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAndToNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.isNotEmpty?Positioned(
                  top: Dimensions.height20 * 4,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: 0,
                  child: Container(
                    // margin: EdgeInsets.only(top:Dimensions.height15),
                    // color:Colors.red,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (cartController) {
                        var _cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index) {
                              return SizedBox(
                                width: double.maxFinite,
                                height: Dimensions.height20 * 5,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          var popularIndex =
                                          Get.find<PopularNftController>()
                                              .popularNftList
                                              .indexOf(_cartList[index].nft!);
                                          if (popularIndex >= 0) {
                                            Get.toNamed(RouteHelper.getPopularNft(popularIndex,"cartpage"));
                                          } else {
                                            var recommendedIndex =
                                            Get.find<RecommendedNftController>()
                                                .recommendedNftList
                                                .indexOf(_cartList[index].nft!);
                                            if(recommendedIndex<0){
                                              Get.snackbar("Orders", "Nft review is not avaiable for history nfts!",
                                                backgroundColor: AppColors.mainColor,
                                                colorText: Colors.white,
                                              );
                                            }else{
                                              Get.toNamed(RouteHelper.getRecommendedNft(recommendedIndex, "cartpage"));
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                              bottom: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(cartController
                                                      .getItems[index].img!)),
                                              borderRadius: BorderRadius.circular(
                                                  Dimensions.radius20),
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      width: Dimensions.width10,
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                          height: Dimensions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: cartController
                                                    .getItems[index].name!,
                                                color: Colors.black54,
                                              ),
                                              SmallText(text: "Spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: cartController
                                                        .getItems[index].price
                                                        .toString(),
                                                    color: Colors.black54,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: Dimensions.height10,
                                                        bottom: Dimensions.height10,
                                                        left: Dimensions.width10,
                                                        right: Dimensions.width10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions.radius20),
                                                        color: Colors.white),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              cartController.addItemToOrder(
                                                                  _cartList[index].nft!,
                                                                  -1);
                                                            },
                                                            child: const Icon(
                                                              Icons.remove,
                                                              color:
                                                              AppColors.signColor,
                                                            )),
                                                        SizedBox(
                                                          width: Dimensions.width10 / 2,
                                                        ),
                                                        BigText(
                                                            text: _cartList[index]
                                                                .quantity
                                                                .toString()),
                                                        //popularNft.inCartItems.toString()),
                                                        SizedBox(
                                                          width: Dimensions.width10 / 2,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              cartController.addItemToOrder(
                                                                  _cartList[index].nft!,
                                                                  1);
                                                            },
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                              AppColors.signColor,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            });
                      }),
                    ),
                  )):const NoDataPage(text: "Your cart is empty");
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
            builder: (cartController) {
              return  !cartController.isLoading ? cartController.getItems.isNotEmpty ? Container(
                height: Dimensions.bottomHeightBar,
                padding: EdgeInsets.only(top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    color: AppColors.signColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight: Radius.circular(Dimensions.radius20 * 2)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.radius20),
                          color: Colors.white
                      ),
                      child: Row(
                        children: [

                          SizedBox(width: Dimensions.width10 / 2,),
                          BigText(text: "\$ " +
                              cartController.totalAmount.toString()),
                          SizedBox(width: Dimensions.width10 / 2,),

                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if(Get.find<AuthController>().userLoggedIn()){
                          //popularNft.addItem(nft);
                          sendData(cartController);
                        } else {
                          Get.toNamed(RouteHelper.getSignInPage());
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: BigText(
                          text: " Check out", color: Colors.white,),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius20),
                            color: AppColors.mainColor
                        ),
                      ),
                    )
                  ],
                ),
              ): Container(height: 0): CustomLoader();
            })
    );
  }
}
