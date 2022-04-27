import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nftmarketplace/controllers/cart_controller.dart';
import 'package:nftmarketplace/controllers/popular_nft_controller.dart';
import 'package:nftmarketplace/pages/home/main_nft_page.dart';
import 'package:nftmarketplace/widgets/app_column.dart';
import 'package:nftmarketplace/widgets/app_icon.dart';
import 'package:nftmarketplace/widgets/expandable_text_widget.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';


class PopularNftDetail extends StatelessWidget {
  final int pageId;
  const PopularNftDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nft = Get.find<PopularNftController>().popularNftList[pageId];
    Get.find<PopularNftController>().initNft(nft,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularNftImageSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:  NetworkImage(nft.img!))),
              )),
          //icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    Get.to(()=>MainNFTPage());
          },
                    child:
                    AppIcon(icon: Icons.arrow_back_ios)
                ),
                GetBuilder<PopularNftController>(builder:(controller){
                  return Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      Get.find<PopularNftController>().totalItems>=1?
                      Positioned(
                        right:0,top:0,
                          child:AppIcon(icon: Icons.circle,size:20,
                        iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,)):
                      Container(),
                      Get.find<PopularNftController>().totalItems>=1?
                      Positioned(
                          right:5,top:1,
                          child:BigText(text:Get.find<PopularNftController>().totalItems.toString(),
                          size: 12, color: Colors.white,
                          ),):
                      Container(),
                    ],
                  );
                })
              ],
            ),
          ),
          //introduction of nft
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularNftImageSize - 20,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),
                    ),
                    color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: nft.name!, stars:nft.stars!),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: nft.description!)))
                  ],
                ),
              ))



        ],
      ),
      bottomNavigationBar: GetBuilder<PopularNftController>(builder: (popularNft){
        return Container(
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
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){

                          popularNft.setQuantity(false);
                        },
                        child: Icon(Icons.remove,color: AppColors.signColor,)),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularNft.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                        onTap: (){

                          popularNft.setQuantity(true);
                        },
                        child: Icon(Icons.add,color: AppColors.signColor,)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  popularNft.addItem(nft);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                      child: BigText(text: "\$${nft.price!} | Add", color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
