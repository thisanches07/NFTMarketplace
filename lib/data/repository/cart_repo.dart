import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nftmarketplace/controllers/user_controller.dart';
import 'package:nftmarketplace/data/api/api_client.dart';
import 'package:nftmarketplace/models/item_insert_model.dart';
import 'package:nftmarketplace/models/order_insert_model.dart';
import 'package:nftmarketplace/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CartRepo({required this.apiClient, required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  late final OrderInsertModel _orderInsertModel = OrderInsertModel();

  void addToCartList(List<CartModel> cartList){
    var time = getDate().toString();
    cart=[];
    //convert objects to String because sharedPreferences only accepts strings
    for (var element in cartList) {
      element.time = time;
      continue;
    }
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
  }

  Future<void> addItemToOrder(List<ItemInsertModel> items) async {
    
    var time = getDate();
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');

    _orderInsertModel.items ??= [];

    Get.find<UserController>().getUserInfo();
    _orderInsertModel.date = formatter.format(time);
    _orderInsertModel.userId = Get.find<UserController>().userModel?.id;
    _orderInsertModel.items = items;
    Response response = await createOrderList(_orderInsertModel);
    if (response.statusCode == 201){
      print("successfully");
    } else {
      print(response.body);
    }
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList=[];

    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory=[];

    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(int i=0;i<cart.length;i++){
        cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }

  Future<Response> getOrdersList() async {
    return await apiClient.getData(AppConstants.ORDER_URI);
  }

  Future<Response> createOrderList(OrderInsertModel orderInsertModel) async {
    return await apiClient.postData(AppConstants.ORDER_URI, orderInsertModel.toJson());
  }

  DateTime getDate(){
    var time = DateTime.now().toLocal();
    return time;
  }
}