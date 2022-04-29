import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/nfts_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(NftModel nft, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(nft.id!)) {
      _items.update(nft.id!, (value) {

        totalQuantity=value.quantity!+quantity;

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      });

      if(totalQuantity<=0){
        _items.remove(nft.id);
      }
    } else {
      if(quantity>0){
        _items.putIfAbsent(nft.id!, () {
          return CartModel(
            id: nft.id,
            name: nft.name,
            price: nft.price,
            img: nft.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
          );
        });
      }else{
        Get.snackbar("Item count", "You should at least add an item in the cart!",
                backgroundColor: AppColors.mainColor,
                colorText: Colors.white,
        );
      }
    }
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
}
