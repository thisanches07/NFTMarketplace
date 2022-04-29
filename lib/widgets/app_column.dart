import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftmarketplace/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final int stars;
  const AppColumn({Key? key, required this.text, required this.stars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26,),
        SizedBox(
          height: Dimensions.height10,
        ),
        //comments section
        Row(
          children: [
            Wrap(
              children: List.generate(stars, (index) {
                return Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 15,
                );
              }),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "1234"),
            SizedBox(
              width: 5,
            ),
            SmallText(text: "comments")
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        //Price and Popularity
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.whatshot_outlined,
                text: "Rare",
                iconColor: AppColors.starColor),
            IconAndTextWidget(
                icon: Icons.monetization_on,
                text: "High",
                iconColor: AppColors.moneyColor),
            IconAndTextWidget(
                icon: Icons.workspace_premium_sharp,
                text: "old",
                iconColor: AppColors.ageColor)
          ],
        )
      ],
    );
  }
}

