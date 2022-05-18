import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nftmarketplace/controllers/cart_controller.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/widgets/app_icon.dart';
import 'package:nftmarketplace/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../utils/dimensions.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var getCartHistoryList = Get.find<CartController>().getCartHistoryList();
    Map<String, int> cartItemsPerOrder = Map();

    for(int i=0; i<getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();

    var listCounter= 0;
    return Scaffold(

      body: Column(
        children: [
          Container(
            height: 100,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Orders",color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,)
              ],
            ),
          ),
          Expanded(child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20
            ),
            child: ListView(
              children: [
                for(int i=0;i<itemsPerOrder.length;i++)
                  Container(
                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: "15/05/2022"),
                        Row(
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              children: List.generate(itemsPerOrder[i], (index) {
                                if(listCounter<getCartHistoryList.length){
                                  listCounter++;
                                }
                                return Container(
                                  height: 80,
                                    width: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                         getCartHistoryList[listCounter-1].nft!.img!
                                      )
                                    )
                                  ),
                                );
                              }
                              )
                            )
                          ],
                        )
                      ],
                    ),

                  )
              ],
            ),
          ))
        ],
      )
    );
  }
}
