import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftmarketplace/widgets/app_icon.dart';
import 'package:nftmarketplace/widgets/big_text.dart';
import 'package:nftmarketplace/widgets/expandable_text_widget.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class RecommendedNftDetail extends StatelessWidget {
  const RecommendedNftDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: BigText(
                        size: Dimensions.font26,
                        text: "Prime Ape Bitcoin Edition")),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20))),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.blackColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/primeApe2.jpg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                child: ExpandableTextWidget(
                    text:
                        "Plenty of apes came before. But most were mere chimpanzees without any real form or function in the Metaverse. The Primus Ethereum Mammal, also known as the Prime Ape, is different. Plenty of apes came before. But most were mere chimpanzees without any real form or function in the Metaverse. The Primus Ethereum Mammal, also known as the Prime Ape, is different. Plenty of apes came before. But most were mere chimpanzees without any real form or function in the Metaverse. The Primus Ethereum Mammal, also known as the Prime Ape, is different. Plenty of apes came before. But most were mere chimpanzees without any real form or function in the Metaverse. The Primus Ethereum Mammal, also known as the Prime Ape, is different. Plenty of apes came before. But most were mere chimpanzees without any real form or function in the Metaverse. The Primus Ethereum Mammal, also known as the Prime Ape, is different. Plenty of apes came before. But most were mere chimpanzees without any real form or function in the Metaverse. The Primus Ethereum Mammal, also known as the Prime Ape, is different. Plenty of apes came before. But most were mere chimpanzees without any real form or function in the Metaverse. The Primus Ethereum Mammal, also known as the Prime Ape, is different. Plenty of apes came before. But most were mere chimpanzees without any real form or function in the Metaverse. The Primus Ethereum Mammal, also known as the Prime Ape, is different. Plenty of apes came before. But most were mere chimpanzees without any real form or function in the Metaverse. The Primus Ethereum Mammal, also known as the Prime Ape, is different"),
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.remove),
                BigText(
                  text: "\$12.88 " + " X " + " 0 ",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                AppIcon(
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.add),
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height20,
                bottom: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.signColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    )),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(
                    text: "\$10 | Add to cart",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
