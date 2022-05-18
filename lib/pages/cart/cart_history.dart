import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:nftmarketplace/controllers/cart_controller.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/widgets/app_icon.dart';
import 'package:nftmarketplace/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/widgets/small_text.dart';
import '../../utils/dimensions.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();

    var listCounter = 0;
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: Dimensions.height10 * 10,
          color: AppColors.mainColor,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: Dimensions.height45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(
                text: "Orders",
                color: Colors.white,
              ),
              AppIcon(
                icon: Icons.shopping_cart,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
              )
            ],
          ),
        ),
        Expanded(
            child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          height: Dimensions.height30 * 4,
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (() {
                                DateTime parseDate =
                                    DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                        getCartHistoryList[listCounter].time!);
                                var inputDate =
                                    DateTime.parse(parseDate.toString());
                                var outputFormat =
                                    DateFormat("MM/dd/yyyy hh:mm a");
                                var outputDate = outputFormat.format(inputDate);
                                return BigText(text: outputDate);
                              }()),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPerOrder[i],
                                          (index) {
                                        if (listCounter <
                                            getCartHistoryList.length) {
                                          listCounter++;
                                        }
                                        return index <= 2
                                            ? Container(
                                                height: Dimensions.height20 * 4,
                                                width: Dimensions.height20 * 4,
                                                margin: EdgeInsets.only(
                                                    right:
                                                        Dimensions.width10 / 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius15 /
                                                                2),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            getCartHistoryList[
                                                                    listCounter -
                                                                        1]
                                                                .nft!
                                                                .img!))),
                                              )
                                            : Container();
                                      })),
                                  Container(
                                    height: Dimensions.height20 * 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SmallText(
                                          text: "Total",
                                          color: AppColors.mainBlackColor,
                                        ),
                                        BigText(
                                          text: itemsPerOrder[i].toString() +
                                              " Items",
                                          color: AppColors.mainBlackColor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.width10 / 2,
                                              vertical:
                                                  Dimensions.height10 / 2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 3),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.mainColor)),
                                          child: SmallText(
                                            text: "one more",
                                            color: AppColors.mainColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                )))
      ],
    ));
  }
}
