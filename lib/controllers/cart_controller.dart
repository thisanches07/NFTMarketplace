import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/models/item_insert_model.dart';
import 'package:nftmarketplace/models/order_model.dart';
import 'package:nftmarketplace/models/response_model.dart';
import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/nfts_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  Map<int, ItemInsertModel> _itemsToOrder = {};
  Map<int, ItemInsertModel> get itemToOrder => _itemsToOrder;

  bool _isLoading = false;
  List<OrderModel>? _orderList;

  bool get isLoading => _isLoading;
  List<OrderModel>? get orderList => _orderList;

  //Only for storage and sharedpreferences
  List<CartModel> storageItems=[];

  void addItemToOrder(NftModel nft, int quantity) {
    var totalQuantityItemsToOrder = 0;
    var totalQuantityItems = 0;
    if (_itemsToOrder.containsKey(nft.id!) && _items.containsKey(nft.id!)) {
      _itemsToOrder.update(nft.id!, (value) {
        totalQuantityItemsToOrder=value.quantity!+quantity;
        return ItemInsertModel(
          id: value.id,
          amount: nft.price! * quantity,
          quantity: value.quantity! + quantity,
          nftId: nft.id,
        );
      });

      if(totalQuantityItemsToOrder <= 0){
        _itemsToOrder.remove(nft.id);
      }

      _items.update(nft.id!, (value) {
        totalQuantityItems = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          nft: nft,
        );
      });

      if(totalQuantityItems <= 0){
        _items.remove(nft.id);
      }

    } else {
      if(quantity>0){
        _itemsToOrder.putIfAbsent(nft.id!, () {
          return ItemInsertModel(
            id: nft.id,
            amount: nft.price! * quantity,
            quantity: quantity,
            nftId: nft.id,
          );
        });
        _items.putIfAbsent(nft.id!, () {
          return CartModel(
            id: nft.id,
            name: nft.name,
            price: nft.price,
            img: nft.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            nft: nft,
          );
        });
      }else{
        Get.snackbar("Item count", "You should at least add an item in the cart!",
                backgroundColor: AppColors.mainColor,
                colorText: Colors.white,
        );
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(NftModel nft) {
    if (_items.containsKey(nft.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(NftModel nft) {
    var quantity = 0;
    if (_items.containsKey(nft.id)) {
      _items.forEach((key, value) {
        if (key == nft.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  List<ItemInsertModel> get getItemsToOrder {
    return _itemsToOrder.entries.map((e) {
      return e.value;
    }).toList();
  }

  double get totalAmount{
    var total=0.0;

    _items.forEach((key, value) {
      total += value.quantity!*value.price!;
    });
    return total;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
  return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems=items;

    for(int i=0;i<storageItems.length;i++){
      _items.putIfAbsent(storageItems[i].nft!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items={};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems){
    _items={};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void addItemToOrderList(){
    cartRepo.addItemToOrder(getItemsToOrder);
    update();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }

  Future<ResponseModel> getOrdersList() async {
    _isLoading = true;
    Response response = await cartRepo.getOrdersList();
    late  ResponseModel responseModel;
    if (response.statusCode == 200) {
      late List list = response.body;
      _orderList = list.map((e) => OrderModel.fromJson(e)).toList();
      responseModel = ResponseModel(true, "successfully");
    } else {
      _orderList = [];
      responseModel = ResponseModel(false, response.body["message"]!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

}
