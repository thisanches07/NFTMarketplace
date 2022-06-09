import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:nftmarketplace/base/custom_loader.dart';
import 'package:nftmarketplace/controllers/cart_controller.dart';
import 'package:nftmarketplace/models/order_model.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/widgets/app_icon.dart';
import 'package:nftmarketplace/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/widgets/small_text.dart';
import '../../models/cart_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getOrdersList();

    Map<String, int> getCartItemsPerOrder(List<OrderModel> listOrders){
      late Map<String, int> cartItemsPerOrder = Map();
      for (int i = 0; i < listOrders.length; i++) {
          for (int j = 0; j < listOrders[i].items!.length; j++){
            if (cartItemsPerOrder.containsKey(listOrders[i].date)) {
            late String date = listOrders[i].date!;
              cartItemsPerOrder.update(
                  date, (value) => ++value);
            } else {
              cartItemsPerOrder.putIfAbsent(listOrders[i].date!, () => 1);
            }
          }
      }
      // print(cartItemsPerOrder);
      return cartItemsPerOrder;
    }

    List<int> cartItemsPerOrderToList(Map<String, int> cartItems) {
      return cartItems.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList(Map<String, int> cartItems) {
      return cartItems.entries.map((e) => e.key).toList();
    }

    var listCounter = 0;

    List<List<Widget>> getListImages(List<OrderModel> _orderListModel){
      late List<List<Widget>> _listItemsImage = [];
      _orderListModel.removeWhere((element) => element.items!.length <= 0);
      print(_orderListModel);
      for (var e in _orderListModel){
        late List<Widget> _listImages = [];
        if(e.items!.length > 0){
        for (var el in e.items ?? []){
            _listImages.add(
              Container(
                  height: Dimensions.height20 * 3.6,
                  width: Dimensions.height20 * 3.6,
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
                          image: // el != null ? NetworkImage(el.nft.img.toString()):
                          NetworkImage("https://mrconfeccoes.com.br/wp-content/uploads/2018/03/default.jpg")
                      ),
                  )
              )
            );
          }
          _listItemsImage.add(_listImages);
        } else {
          _listItemsImage.add([Container()]);
        }
      }
      return _listItemsImage;
    }

    return GetBuilder<CartController>(builder: (cartController){
      var cartHistoryList =
        cartController.orderList!.reversed.toList();
      var cartItemsList = getCartItemsPerOrder(cartHistoryList);
      return !cartController.isLoading ? Scaffold(
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
                SizedBox(
                  width: Dimensions.width20 * 5,
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
                        for (int i = 0; i < cartItemsList.length; i++)
                          Container(
                            height: Dimensions.height30 * 4,
                            margin: EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (() {
                                  DateTime parseDate =
                                      DateFormat("yyyy-MM-ddTHH:mm:ss").parse(
                                          cartHistoryList[listCounter].date!);
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
                                    Container(
                                      clipBehavior: Clip.none,
                                      child: Expanded(
                                        child:  
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child:
                                            Wrap(
                                              direction: Axis.horizontal,
                                              children: getListImages(cartHistoryList)[i].toList(),
                                            ),
                                        ),
                                      ),
                                    ),
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
                                            text: cartItemsPerOrderToList(cartItemsList)[i].toString() +
                                                " Items",
                                            color: AppColors.mainBlackColor,
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              var orderTime = cartOrderTimeToList(cartItemsList);
                                              Map<int,CartModel> moreOrder={};
                                              for(int j=0;j<cartHistoryList.length;j++){
                                                if(cartHistoryList[j].date == orderTime[i]){
                                                  moreOrder.putIfAbsent(cartHistoryList[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(cartHistoryList[j])))
                                                  );
                                                }
                                              }
                                              Get.find<CartController>().setItems = moreOrder;
                                              Get.find<CartController>().addToCartList();
                                              Get.toNamed(RouteHelper.getCartPage());
                                            },
                                            child: Container(
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
      )):CustomLoader();
    });
  }
}
