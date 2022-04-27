import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/controllers/cart_controller.dart';
import 'package:nftmarketplace/data/repository/popular_nft_repo.dart';
import 'package:nftmarketplace/utils/colors.dart';

import '../models/cart_model.dart';
import '../models/nfts_model.dart';

class PopularNftController extends GetxController {
  final PopularNftRepo popularNftRepo;

  PopularNftController({required this.popularNftRepo});

  List<dynamic> _popularNftList = [];

  List<dynamic> get popularNftList => _popularNftList;
  late CartController _cart;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  int get quantity => _quantity;
  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularNftList() async {
    Response response = await popularNftRepo.getPopularNftList();
    if (response.statusCode == 200) {
      _popularNftList = [];
      _popularNftList.addAll(Nft.fromJson(response.body).nfts);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity= - _inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initNft(NftModel nft, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(nft);
    //get from storage _inCartItems
    if (exist) {
      _inCartItems = _cart.getQuantity(nft);
    }
  }

  void addItem(NftModel nft) {
    _cart.addItem(nft, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(nft);
    _cart.items.forEach((key, value) {
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}
