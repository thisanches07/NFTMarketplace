import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/controllers/cart_controller.dart';
import 'package:nftmarketplace/data/repository/popular_nft_repo.dart';
import 'package:nftmarketplace/utils/colors.dart';

import '../models/nfts_model.dart';

class PopularNftController extends GetxController{
  final PopularNftRepo popularNftRepo;
  PopularNftController({required this.popularNftRepo});
  List<dynamic> _popularNftList=[];
  List<dynamic> get popularNftList => _popularNftList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity=0;
  int get quantity=> _quantity;
  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;

  Future<void> getPopularNftList() async{
    Response response = await popularNftRepo.getPopularNftList();
    if(response.statusCode == 200){
      _popularNftList=[];
      _popularNftList.addAll(Nft.fromJson(response.body).nfts);
      _isLoaded=true;
      update();
    }else{
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity=checkQuantity(_quantity+1);
    }else{
      _quantity=checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if(quantity<0){
      Get.snackbar("Item count", "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    }else if(quantity>20){
      Get.snackbar("Item count", "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initNft(CartController cart){
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    //get from storage _inCartItems
  }

  void addItem(NftModel nft){
    _cart.addItem(nft, _quantity);
  }
}