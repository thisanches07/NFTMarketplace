import 'package:nftmarketplace/models/nfts_model.dart';

class CartModel {
  int? id;
  String? name;
  double? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  NftModel? nft;

  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.quantity,
        this.isExist,
        this.time,
        this.nft,
  });

  factory CartModel.fromJson(Map<String, dynamic> json){
    return CartModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      img: json['img'],
      quantity: json['quantity'],
      isExist: json['isExist'],
      time: json['time'],
      nft: NftModel.fromJson(json['nft'])
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "quantity":this.quantity,
      "isExist":this.isExist,
      "time":this.time,
      "nft" :this.nft!.toJson()
    };
  }
}