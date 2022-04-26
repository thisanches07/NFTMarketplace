import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/nfts_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  void addItem(NftModel nft, int quantity) {
    print(nft.id!.toString());
    _items.putIfAbsent(
        nft.id!,
        () {
              print("adding item to the cart" + nft.id!.toString() + "quantity " + quantity.toString());
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
  }
}
