import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftmarketplace/widgets/app_icon.dart';

import '../../utils/dimensions.dart';

class PopularNftDetail extends StatelessWidget {
  const PopularNftDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularNftImageSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/image/primeApe1.jpg"))),
              )),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
          )
        ],
      ),
    );
  }
}
